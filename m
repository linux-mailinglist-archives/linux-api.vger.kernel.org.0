Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D9A16FF85E
	for <lists+linux-api@lfdr.de>; Thu, 11 May 2023 19:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238642AbjEKR0m (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 11 May 2023 13:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjEKR0l (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 11 May 2023 13:26:41 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC760E5D
        for <linux-api@vger.kernel.org>; Thu, 11 May 2023 10:26:39 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a640c23a62f3a-966400ee79aso1157717766b.0
        for <linux-api@vger.kernel.org>; Thu, 11 May 2023 10:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683825998; x=1686417998;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uP9gY2ig7661BNo9d6NrRtc/h1Kpn5dWShHq/4pbz/4=;
        b=Grnvil76PcNoOxwzxMpMBfPoZbX+rnx2mjjnpR5zblzOde/9v0Tpvjt7ofQPvvAXXD
         inJ1aINkkGhZ/Ys03i+Ijg5T9OUc5wrKtJKrVr9aWelynK0UZqTbyuo1dScGrGlo0fDL
         GmkQX2icVcOmdogAk5+VeClt6t+j0h89i3VfR5rYZOXJFukXDn8uLtNGn9DUKrLRE1P3
         edQ7ByvlNU53b+rES3auUn4TXtzjPm4T7HrZq1/jwzlJWaKKFEviW4x8n8YbWnDIqKBs
         S9uxR3GKMOYXMrVUI+OIQA49Yw5J5klbfAN5LUanjHaecmBfIqIfW/Q2Q0YshNif4cCb
         veTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683825998; x=1686417998;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uP9gY2ig7661BNo9d6NrRtc/h1Kpn5dWShHq/4pbz/4=;
        b=VHHHio5hf3VKt8svPU9MTjVdZXwKlpNKKIfkHcufBtO1xy7cssl6eAanDdZzah/jhN
         ORCUUy/AIYnHaTFWFt6Z10p+QQc9Ze+RuzdEXasHne8cL1zdzXvyufq4vRgWEc9lYYG6
         M8q9CZcUMfsvft1Ec7spVeS9hf+hXFp1464tQBBZFjrlYND4HSYmEm/JXKqk77A7U/YD
         7Z1SY4TUrQHffeK2mSgnEWdGtnPqbTI9Y8oJSqItx57z4KnffA4BJkPGBQ2dwnlhsYQy
         TsV/8xFMTwmxmxxD9Qh33nfmzOvF0hgi6a15vFnjC86sstHl7OaLkHBnut6Zwp9Pdr+m
         MD4Q==
X-Gm-Message-State: AC+VfDy4KuNtIHruAZnHPvLTJju7g7NCNy2YsWluP8K/0dJnhltWZfEO
        e7sBMOrNMr5OH8bw2OMM9xupY77y6woxuCkwpEY=
X-Google-Smtp-Source: ACHHUZ7f0mYUlhkmfqFOa7upgF3+P9haIqFzcQiaDvEE7sLdXrepLdsjEQXj85Vedo+/8g25qQEmx2pHu6PWK0EAtSA=
X-Received: by 2002:a17:907:94c3:b0:969:e7da:fca0 with SMTP id
 dn3-20020a17090794c300b00969e7dafca0mr11018637ejc.8.1683825998275; Thu, 11
 May 2023 10:26:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a98:af89:0:b0:1c5:4782:3dff with HTTP; Thu, 11 May 2023
 10:26:37 -0700 (PDT)
Reply-To: mrsubhashmejia30@aol.com
From:   "Mr. Subhash Mejia." <kmyriamgrace@gmail.com>
Date:   Thu, 11 May 2023 17:26:37 +0000
Message-ID: <CAMGn9=Y=McgUKVZ28fVDd0mDVScV8T62zeV=mz13Uh9wjVjFPg@mail.gmail.com>
Subject: Hello Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:642 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4925]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kmyriamgrace[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mrsubhashmejia30[at]aol.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.9 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Greetings,

My name is Mr.Subhash Mejia,a Native of Sanso Community in
Morila-Sikasso region of Republic Of Mali, a French speaking West
African Country. I am a member of the said Community and the Head of
sales, marketing, advertising, communication and sourcing agent for
the Gold Bars.

My community  have kilos of Gold bars for immediate delivery to any
buyer refinery.

Specifications of our gold dore bars are 22,23 Carats and Purity of
96% Minimum. Origin is Republic of Mali.

Our best prices will be made available on the offer based on the options.
I will be hoping to hearing from you again.Then you can contact me with my email
addres;[mrsubhashmejia30@aol.com]


Thanks and Have a nice day

Mr. Subhash Mejia.
