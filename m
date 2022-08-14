Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B85F591ECE
	for <lists+linux-api@lfdr.de>; Sun, 14 Aug 2022 08:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240298AbiHNGz6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 14 Aug 2022 02:55:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240102AbiHNGz5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 14 Aug 2022 02:55:57 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69FE51838A
        for <linux-api@vger.kernel.org>; Sat, 13 Aug 2022 23:55:56 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r22so4171056pgm.5
        for <linux-api@vger.kernel.org>; Sat, 13 Aug 2022 23:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=t2xo6E1uDVXBL9rtyALdnKwGeumoPy0aKoIQA7ijnWQ=;
        b=MqAPICeVhhv8JNaJyYm1TWd5WmdxtVUoiCrG/EZjfKB4ytOJnHdXZyEqxLPVGNfNBS
         /YMZb5BSwz39TiH8EDB+DX56gaN8O3Qpgn23XKopCTXbpCa7vu8EBejmQRoO2fhgMjgA
         Bzq1DNAINpj5GPHb3ooFWKDHMc99PrxLdCFqxG07tvyRZPWnpmfqjqI1ZSW39dHFxXMW
         CxJt5Fb+bTnPYw5nJ549cBh6cSbOFo8i6UxGrmxH/ueCVl0GM7zr+tdcX0Wf7KYEVoLb
         Iwr06Swhn5tlKV5SAkOB6w7G2O1ZX/GAA6pdtMJqclNiWoMDYZiX/YohD//u2BGe7hJy
         hAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=t2xo6E1uDVXBL9rtyALdnKwGeumoPy0aKoIQA7ijnWQ=;
        b=Q3wwRxaeuiw+GnYlpzVt2V6pVyrJC3aVZKXPnv2NTcjV7MZcC9FZRnq0bxzE1tEaTR
         fDD8lD8ux3LnmBhaX7u3mX+I4j7l8mEVzHlQGbBHklrNO1C8b8I04ZJdWjoFFhaGN1HD
         lFrbRjGECnEjl+u4w3J3CtE4Nezc83XJwmbezdSPbDESzonzdLwzx3Rdh90WA/s7poc4
         TcRsqml6kzefObFu3Ggeksi5YEBLLFuTcCPiyNUDWt2GZ9Fw3Q7w/Y9cM4noIgXUFcY1
         eNlrDgL6a3fM51CRhJH2+90Pv6Yl6AYkW+2/Ugf/pKS0z5fCD3Q+uXjEPNya8XVcJT9s
         Odgg==
X-Gm-Message-State: ACgBeo3TQ8nQMsP3Zdd87vGZkMLuOrtvgWdfKn7TWmDlERedRCvwqAG3
        7lBBc71uwnyuzVZfLEXL6b9d1GqI67qjBmqWepc=
X-Google-Smtp-Source: AA6agR5elfAUjGi08yNg5e1Sdw4zvMlT44ej3UFOsyaeQs9wka5mooUZuLNRDDwbKW78CIc4w0pH+d5YrPArsLXFhWU=
X-Received: by 2002:a63:5d4e:0:b0:41d:2966:74e7 with SMTP id
 o14-20020a635d4e000000b0041d296674e7mr8982865pgm.526.1660460155820; Sat, 13
 Aug 2022 23:55:55 -0700 (PDT)
MIME-Version: 1.0
Sender: rayngwu1@gmail.com
Received: by 2002:a05:6a11:5a3:b0:298:df7d:dd9d with HTTP; Sat, 13 Aug 2022
 23:55:55 -0700 (PDT)
From:   "mydesk.ceoinfo@barclaysbank.co.uk" <nigelhiggins.md5@gmail.com>
Date:   Sun, 14 Aug 2022 07:55:55 +0100
X-Google-Sender-Auth: jrKXrTDUrtv8GIGTit2PT5vR8-w
Message-ID: <CAFUkv_Dw7a63HosRqA_6_fKL7vimCy_XF-JTGL5cHfq4cBuZ9w@mail.gmail.com>
Subject: RE PAYMENT NOTIFICATION UPDATE
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_2_EMAILS_SHORT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,YOU_INHERIT autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:542 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [rayngwu1[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [rayngwu1[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.5 YOU_INHERIT Discussing your inheritance
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.9 FROM_2_EMAILS_SHORT Short body and From looks like 2 different
        *      emails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

-- 
Hello,

I am the Group Chairman of Barclays Bank Plc. This is to formally
notify you that your delayed inheritance payment has been irrevocably
released to you today after a successful review. Get back for more
details.

Yours sincerely,

Nigel Higgins, (Group Chairman),
Barclays Bank Plc,
Registered number: 1026167,
1 Churchill Place, London, ENG E14 5HP,
SWIFT Code: BARCGB21,
Direct Telephone: +44 770 000 8965,
WhatsApp, SMS Number: + 44 787 229 9022
www.barclays.co.uk
