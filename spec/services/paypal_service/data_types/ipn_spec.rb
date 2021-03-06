require 'spec_helper'

describe PaypalService::DataTypes::IPN do

  # sample request params hashes

  order_created = {
    "txn_type"=> "express_checkout",
    "payment_date"=>"23:01:12 Sep 30, 2014 PDT",
    "last_name"=>"kjh",
    "receipt_id"=>"3609-0935-6989-4532",
    "residence_country"=>"GB",
    "pending_reason"=>"order",
    "item_name"=>"desc",
    "payment_gross"=>"",
    "mc_currency"=>"GBP",
    "verify_sign"=>"AWA3gWBJwNK7791rbM2f2XOEyzvbACNyf78ytgUBQNkB-vdmxBoY2Ait",
    "payer_status"=>"unverified",
    "test_ipn"=>"1",
    "tax"=>"0.00",
    "payer_email"=>"foobar@barfoo.com",
    "txn_id"=>"O-8VG2704956180171B",
    "quantity"=>"1",
    "receiver_email"=>"dev+paypal-user1@sharetribe.com",
    "first_name"=>"ljkh",
    "payer_id"=>"6M39X6RCYVUD6",
    "receiver_id"=>"URAPMR7WHFAWY",
    "item_number"=>"",
    "handling_amount"=>"0.00",
    "payment_status"=>"Pending",
    "shipping"=>"0.00",
    "mc_gross"=>"1.20",
    "custom"=>"",
    "transaction_entity"=>"order",
    "charset"=>"windows-1252",
    "notify_version"=>"3.8",
    "ipn_track_id"=>"d9520dcb18f6"
  }

  auth_created = {
    "mc_gross"=>"1.20",
    "auth_exp"=>"23:50:00 Oct 03, 2014 PDT",
    "protection_eligibility"=>"Ineligible",
    "payer_id"=>"6M39X6RCYVUD6",
    "tax"=>"0.00",
    "payment_date"=>"23:04:07 Sep 30, 2014 PDT",
    "payment_status"=>"Pending",
    "charset"=>"windows-1252",
    "first_name"=>"ljkh",
    "transaction_entity"=>"auth",
    "notify_version"=>"3.8",
    "custom"=>"",
    "payer_status"=>"unverified",
    "quantity"=>"1",
    "verify_sign"=>"A2S1fniRGsoquzRDbs4f5rc383f8A9BZtlhOnNThbBpkIOUsU.U6RJlP",
    "payer_email"=>"foobar@barfoo.com",
    "parent_txn_id"=>"O-8VG2704956180171B",
    "txn_id"=>"0L584749FU2628910",
    "payment_type"=>"instant",
    "remaining_settle"=>"10",
    "auth_id"=>"0L584749FU2628910",
    "last_name"=>"kjh",
    "receiver_email"=>"dev+paypal-user1@sharetribe.com",
    "auth_amount"=>"1.20",
    "receiver_id"=>"URAPMR7WHFAWY",
    "pending_reason"=>"authorization",
    "txn_type"=>"express_checkout",
    "item_name"=>"desc",
    "mc_currency"=>"GBP",
    "item_number"=>"",
    "residence_country"=>"GB",
    "test_ipn"=>"1",
    "receipt_id"=>"3609-0935-6989-4532",
    "handling_amount"=>"0.00",
    "transaction_subject"=>"",
    "payment_gross"=>"",
    "auth_status"=>"Pending",
    "shipping"=>"0.00",
    "ipn_track_id"=>"35b2bed5966"
  }

  payment_voided = {
    "mc_gross"=>"100.00",
    "invoice"=>"2-91",
    "auth_exp"=>"23:50:00 Nov 06, 2014 PST",
    "protection_eligibility"=>"Ineligible",
    "item_number1"=>"",
    "payer_id"=>"7LFUVCDKGARH4",
    "tax"=>"0.00",
    "payment_date"=>"04:15:57 Nov 03, 2014 PST",
    "payment_status"=>"Voided",
    "charset"=>"windows-1252",
    "mc_shipping"=>"0.00",
    "mc_handling"=>"0.00",
    "first_name"=>"SandboxTest",
    "transaction_entity"=>"auth",
    "notify_version"=>"3.8",
    "custom"=>"",
    "payer_status"=>"verified",
    "num_cart_items"=>"1",
    "mc_handling1"=>"0.00",
    "verify_sign"=>"AJUc1Ia4SIzAsHpmMszE5xpkoPoVAFydOpOKQmMLPy9fUgcPT8VPsa-a",
    "payer_email"=>"dev+paypal-user2@sharetribe.com",
    "mc_shipping1"=>"0.00",
    "tax1"=>"0.00",
    "parent_txn_id"=>"O-4XS63437S6833583E",
    "txn_id"=>"8X37683373099502U",
    "payment_type"=>"instant",
    "remaining_settle"=>"10",
    "auth_id"=>"8X37683373099502U",
    "payer_business_name"=>"SandboxTest Account's Test Store",
    "last_name"=>"Account",
    "item_name1"=>"Testing",
    "receiver_email"=>"dev+paypal-user1@sharetribe.com",
    "auth_amount"=>"100.00",
    "quantity1"=>"1",
    "receiver_id"=>"URAPMR7WHFAWY",
    "txn_type"=>"cart",
    "mc_gross_1"=>"100.00",
    "mc_currency"=>"GBP",
    "residence_country"=>"GB",
    "test_ipn"=>"1",
    "transaction_subject"=>"",
    "payment_gross"=>"",
    "auth_status"=>"Voided",
    "ipn_track_id"=>"deb829141b651"
  }

  payment_completed = {
    "mc_gross"=>"1.20",
    "auth_exp"=>"23:50:00 Oct 03, 2014 PDT",
    "protection_eligibility"=>"Ineligible",
    "payer_id"=>"6M39X6RCYVUD6",
    "tax"=>"0.00",
    "payment_date"=>"23:06:08 Sep 30, 2014 PDT",
    "payment_status"=>"Completed",
    "charset"=>"windows-1252",
    "first_name"=>"ljkh",
    "transaction_entity"=>"payment",
    "mc_fee"=>"0.24",
    "notify_version"=>"3.8",
    "custom"=>"",
    "payer_status"=>"unverified",
    "quantity"=>"1",
    "verify_sign"=>"AI36sk2Aln3iC.t.mla1wMizPRcQABXSTKSHu4uUNy3eGMDpl0JESlHN",
    "payer_email"=>"foobar@barfoo.com",
    "parent_txn_id"=>"0L584749FU2628910",
    "txn_id"=>"4BV77412CY217203L",
    "payment_type"=>"instant",
    "remaining_settle"=>"9",
    "auth_id"=>"0L584749FU2628910",
    "last_name"=>"kjh",
    "receiver_email"=>"dev+paypal-user1@sharetribe.com",
    "auth_amount"=>"1.20",
    "payment_fee"=>"",
    "receiver_id"=>"URAPMR7WHFAWY",
    "txn_type"=>"express_checkout",
    "item_name"=>"desc",
    "mc_currency"=>"GBP",
    "item_number"=>"",
    "residence_country"=>"GB",
    "test_ipn"=>"1",
    "receipt_id"=>"3609-0935-6989-4532",
    "handling_amount"=>"0.00",
    "transaction_subject"=>"",
    "payment_gross"=>"",
    "auth_status"=>"Completed",
    "shipping"=>"0.00",
    "ipn_track_id"=>"cf5793483cf91"
  }

  payment_completed_2 = {
    "auth_amount" => "10.00",
    "auth_exp" => "23:50:02 Nov 13, 2014 PST",
    "auth_id" => "0J90174816752303G",
    "auth_status" => "Completed",
    "charset" => "windows-1252",
    "controller" => "paypal_ipn",
    "custom" => "",
    "first_name" => "Payer",
    "handling_amount" => "0.00",
    "invoice" => "1809-56123",
    "ipn_track_id" => "eecc20fabc404",
    "item_name" => "",
    "item_number" => "",
    "last_name" => "PayerS",
    "mc_currency" => "EUR",
    "mc_gross" => "10.00",
    "notify_version" => "3.8",
    "parent_txn_id" => "O-4677591372287434H",
    "payer_email" => "payper@ex.com",
    "payer_id" => "HTLEEXWH2GJ5H",
    "payer_status" => "verified",
    "payment_date" => "05:32:02 Nov 10, 2014 PST",
    "payment_gross" => "",
    "payment_status" => "Completed",
    "payment_type" => "instant",
    "pending_reason" => "authorization",
    "protection_eligibility" => "Ineligible",
    "quantity" => "1",
    "receiver_email" => "receiver@ex.com",
    "receiver_id" => "XAOENU6KNJRCWC",
    "remaining_settle" => "9",
    "residence_country" => "FI",
    "shipping" => "0.00",
    "tax" => "0.00",
    "transaction_entity" => "auth",
    "transaction_subject" => "",
    "txn_id" => "0J90171846752303G",
    "txn_type" => "cart",
  }

  payment_refunded = {
    "mc_gross"=>"-1.20",
    "auth_exp"=>"23:50:00 Oct 03, 2014 PDT",
    "protection_eligibility"=>"Ineligible",
    "payer_id"=>"6M39X6RCYVUD6",
    "payment_date"=>"23:24:36 Sep 30, 2014 PDT",
    "payment_status"=>"Refunded",
    "charset"=>"windows-1252",
    "first_name"=>"ljkh",
    "transaction_entity"=>"payment",
    "mc_fee"=>"-0.04",
    "notify_version"=>"3.8",
    "reason_code"=>"refund",
    "custom"=>"",
    "verify_sign"=>"AGu.hbwMxRXoqDiyy-IJNOnULnvNAAs8Pg60O96MreRfhHhWgoCGDYFf",
    "payer_email"=>"foobar@barfoo.com",
    "parent_txn_id"=>"4BV77412CY217203L",
    "txn_id"=>"7HX881531H984174B",
    "payment_type"=>"instant",
    "remaining_settle"=>"9",
    "auth_id"=>"0L584749FU2628910",
    "last_name"=>"kjh",
    "receiver_email"=>"dev+paypal-user1@sharetribe.com",
    "payment_fee"=>"",
    "auth_amount"=>"1.20",
    "receiver_id"=>"URAPMR7WHFAWY",
    "item_name"=>"desc",
    "mc_currency"=>"GBP",
    "item_number"=>"",
    "residence_country"=>"GB",
    "test_ipn"=>"1",
    "receipt_id"=>"3609-0935-6989-4532",
    "handling_amount"=>"0.00",
    "transaction_subject"=>"",
    "payment_gross"=>"",
    "shipping"=>"0.00",
    "auth_status"=>"Completed",
    "ipn_track_id"=>"be492945b2622"
  }

  payment_refunded_2 = {
    "mp_custom"=>"",
    "mc_gross"=>"-0.64",
    "invoice"=>"56276-com",
    "mp_currency"=>"EUR",
    "protection_eligibility"=>"Ineligible",
    "item_number1"=>"0",
    "payer_id"=>"XW9NUKKUJACWC",
    "payment_date"=>"05:25:00 Nov 10, 2014 PST",
    "mp_id"=>"B-AOUSH3A4979771B",
    "payment_status" => "Refunded",
    "charset"=>"windows-1252",
    "mc_shipping"=>"0.00",
    "mc_handling"=>"0.00",
    "first_name"=>"Payer",
    "mp_status"=>"0",
    "mc_fee"=>"-0.37",
    "notify_version"=>"3.8",
    "reason_code"=>"refund",
    "custom"=>"",
    "business"=>"business@sharetribe.com",
    "mc_handling1"=>"0.00",
    "verify_sign"=>"AAh-gjasoneuth1123345BYSjRRxpMh.TZTW6.sXma",
    "payer_email"=>"payer@ex.com",
    "mc_shipping1"=>"0.00",
    "tax1"=>"0.00",
    "parent_txn_id"=>"47AOU05AUAOU349131H",
    "txn_id"=>"12344567",
    "payment_type"=>"instant",
    "last_name"=>"PayerS",
    "mp_desc"=>"Grant RealMoneyPaypalMarketplace permission to charge a transaction fee.",
    "item_name1"=>"Commission payment for %{listing_title}",
    "receiver_email"=>"res@ex.com",
    "payment_fee"=>"",
    "mp_cycle_start"=>"10",
    "quantity1"=>"1",
    "receiver_id"=>"ABCDEC10FE",
    "mc_gross_1"=>"0.64",
    "mc_currency"=>"EUR",
    "residence_country"=>"FI",
    "transaction_subject"=>"Marketplace %{service_name} took this commission from transaction regarding %{listing_title}",
    "payment_gross"=>"",
    "ipn_track_id"=>"baf19293942b40"}

  billing_agreement_created = {
    "txn_type"=>"mp_signup",
    "last_name"=>"Account",
    "mp_currency"=>"USD",
    "residence_country"=>"US",
    "mp_status"=>"0",
    "mp_custom"=>"",
    "mp_pay_type"=>"instant",
    "verify_sign"=>"Ai1GUBsAVJLTrgWjhBLUx4LnD5C4ASJgGq5Jhwo7k-eq6ymSzkNPce3s",
    "payer_status"=>"verified",
    "test_ipn"=>"1",
    "payer_email"=>"dev+paypal_us@sharetribe.com",
    "first_name"=>"SandboxTest",
    "payer_id"=>"P6S3ZMLQ25AYU",
    "reason_code"=>"mp_2001",
    "payer_business_name"=>"SandboxTest Account's Test Store",
    "mp_id"=>"B-80N6310848330024M",
    "charset"=>"windows-1252",
    "notify_version"=>"3.8",
    "mp_desc"=>"Grant Sharetribe permission to charge a transaction fee.",
    "mp_cycle_start"=>"14",
    "ipn_track_id"=>"8eb38a4d6fac0"
  }

  billing_agreement_cancelled = {
    "txn_type"=>"mp_cancel",
    "last_name"=>"Account",
    "mp_currency"=>"USD",
    "residence_country"=>"GB",
    "mp_status"=>"1",
    "mp_custom"=>"",
    "verify_sign"=>"ASVYRST0Jt3HL5ZvdLlfhfgxqvNbAjF-ZOgA2kiZUDAEcVV2IHG6RutL",
    "payer_status"=>"verified",
    "test_ipn"=>"1",
    "payer_email"=>"dev+paypal-user1@sharetribe.com",
    "first_name"=>"SandboxTest",
    "payer_id"=>"URAPMR7WHFAWY",
    "reason_code"=>"mp_2002",
    "payer_business_name"=>"SandboxTest Account's Test Store",
    "mp_id"=>"B-5WU95213TP0919018",
    "charset"=>"windows-1252",
    "notify_version"=>"3.8",
    "mp_desc"=>"commissions",
    "mp_cycle_start"=>"1",
    "ipn_track_id"=>"67e92d1e16ac5"
  }

  #This one captured in multi-currency situation
  #If some other pending reason is captured, compare fields
  payment_pending_ext = {
    "mc_gross"=>"100.00",
    "invoice"=>"2-41",
    "auth_exp"=>"23:50:00 Oct 30, 2014 PDT",
    "protection_eligibility"=>"Ineligible",
    "item_number1"=>"",
    "payer_id"=>"7LFUVCDKGARH4",
    "tax"=>"0.00",
    "payment_date"=>"07:05:21 Oct 27, 2014 PDT",
    "payment_status"=>"Pending",
    "charset"=>"windows-1252",
    "mc_shipping"=>"0.00",
    "mc_handling"=>"0.00",
    "first_name"=>"SandboxTest",
    "transaction_entity"=>"payment",
    "notify_version"=>"3.8",
    "custom"=>"",
    "payer_status"=>"verified",
    "num_cart_items"=>"1",
    "verify_sign"=>"Arsl7-LMI7rFwHLn2AZcRGMd.BLwAJFH7WGQjWjJjDuIVjPXV4-qgzMZ",
    "payer_email"=>"dev+paypal-user2@sharetribe.com",
    "parent_txn_id"=>"999243345J942435W",
    "txn_id"=>"60J56194US3230833",
    "payment_type"=>"instant",
    "remaining_settle"=>"9",
    "auth_id"=>"999243345J942435W",
    "payer_business_name"=>"SandboxTest Account's Test Store",
    "last_name"=>"Account",
    "item_name1"=>"Testing",
    "receiver_email"=>"dev+paypal-user1@sharetribe.com",
    "auth_amount"=>"100.00",
    "quantity1"=>"1",
    "receiver_id"=>"URAPMR7WHFAWY",
    "pending_reason"=>"multi_currency",
    "txn_type"=>"cart",
    "mc_gross_1"=>"100.00",
    "mc_currency"=>"USD",
    "residence_country"=>"GB",
    "test_ipn"=>"1",
    "transaction_subject"=>"",
    "payment_gross"=>"100.00",
    "auth_status"=>"Completed",
    "ipn_track_id"=>"7119fe92afd3c"
  }

  payment_denied = {
    "mc_gross"=>"23.00",
    "invoice"=>"1816-56274",
    "auth_exp"=>"23:50:02 Nov 13, 2014 PST",
    "protection_eligibility"=>"Ineligible",
    "item_number1"=>"",
    "payer_id"=>"XXXSNUI6KNJRCWC",
    "tax"=>"0.00",
    "payment_date"=>"04:46:57 Nov 10, 2014 PST",
    "payment_status"=>"Denied",
    "charset"=>"windows-1252",
    "mc_shipping"=>"0.00",
    "mc_handling"=>"0.00",
    "first_name"=>"Payer",
    "transaction_entity"=>"payment",
    "notify_version"=>"3.8",
    "custom"=>"",
    "payer_status"=>"verified",
    "num_cart_items"=>"1",
    "mc_handling1"=>"0.00",
    "verify_sign"=>"AU-csK8ARzBek50hhiQq3LGyRaZJAVBhODYeBFjL3FdAK5LW3DmMUZ6D",
    "payer_email"=>"payer@sharetribe.com",
    "mc_shipping1"=>"0.00",
    "tax1"=>"0.00",
    "parent_txn_id"=>"00000ABCDECEC",
    "txn_id"=>"4BASUNHUSNH",
    "payment_type"=>"instant",
    "remaining_settle"=>"9",
    "auth_id"=>"0ASUNH5413802",
    "last_name"=>"Last",
    "item_name1"=>"Svenks Rally Car",
    "receiver_email"=>"receiver@sharetribe.com",
    "auth_amount"=>"23.00",
    "quantity1"=>"1",
    "receiver_id"=>"HTLXESTNHJ5W",
    "txn_type"=>"cart",
    "mc_gross_1"=>"23.00",
    "mc_currency"=>"SEK",
    "residence_country"=>"FI",
    "transaction_subject"=>"",
    "payment_gross"=>"",
    "auth_status"=>"Completed",
    "ipn_track_id"=>"1239845790gdaho"
  }

  payment_completed_3 = {
    "action" => "ipn_hook",
    "address_city" => "Roma",
    "address_country" => "Italy",
    "address_country_code" => "IT",
    "address_name" => "giovanni foglietta",
    "address_state" => "Roma",
    "address_status" => "unconfirmed",
    "address_street" => "via gregorio VII 111\nint. 12b",
    "address_zip" => "00165",
    "business" => "sharetribe@sharetribe.com",
    "charset" => "windows-1252",
    "controller" => "paypal_ipn",
    "custom" => "",
    "first_name" => "giovanni",
    "invoice" => "INV2-7V4J-HMJT-VD2G-5L2J",
    "invoice_id" => "INV2-7V4J-HMJT-VD2G-5L2J",
    "invoice_number" => "0028",
    "ipn_track_id" => "1cc4a49ba25c",
    "item_name1" => "Payment to Sharetribe for invoice 0028",
    "item_number1" => "",
    "last_name" => "foglietta",
    "mc_currency" => "EUR",
    "mc_fee" => "3.72",
    "mc_gross" => "99.00",
    "mc_gross_1" => "99.00",
    "mc_handling1" => "0.00",
    "mc_shipping" => "0.00",
    "mc_shipping1" => "0.00",
    "notify_version" => "3.8",
    "num_cart_items" => "1",
    "payer_email" => "giovannifoglietta@gmail.com",
    "payer_id" => "4RE3YRHNKV2SL",
    "payer_status" => "unverified",
    "payment_date" => "05:21:07 Nov 14, 2014 PST",
    "payment_fee" => "",
    "payment_gross" => "",
    "payment_status" => "Completed",
    "payment_type" => "instant",
    "protection_eligibility" => "Eligible",
    "quantity1" => "1",
    "receiver_email" => "info@sharetribe.com",
    "receiver_id" => "3H3LLRNQZ5Q2G",
    "residence_country" => "IT",
    "tax1" => "0.00",
    "transaction_subject" => "",
    "txn_id" => "9FA319797P8261059",
    "txn_type" => "invoice_payment",
    "verify_sign" => "AH1pol-O9H-rvd9mM0ld1W1mHNV0AFUqtkq16DTx..JHU9WOSdPL9xy5"
  }

  it "#from_params" do
    input_with_expected_type = [
      [payment_refunded, :payment_refunded],
      [order_created, :order_created],
      [auth_created, :authorization_created],
      [payment_completed, :payment_completed],
      [payment_pending_ext, :payment_pending_ext],
      [payment_voided, :payment_voided],
      [payment_completed_2, :payment_completed],
      [payment_refunded_2, :payment_refunded],
      [payment_denied, :payment_denied],
      [payment_completed_3, :payment_completed]
    ]

    input_with_expected_type.each do |(input, type)|
      expect(PaypalService::DataTypes::IPN.from_params(input)[:type]).to eq(type)
    end
  end

end
