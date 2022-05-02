Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21F08516D16
	for <lists+linux-api@lfdr.de>; Mon,  2 May 2022 11:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234146AbiEBJLp (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 2 May 2022 05:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384139AbiEBJJ2 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 2 May 2022 05:09:28 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9297E08F
        for <linux-api@vger.kernel.org>; Mon,  2 May 2022 02:05:39 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id z99so15888594ede.5
        for <linux-api@vger.kernel.org>; Mon, 02 May 2022 02:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=ltdLotf7TOkPFkMNnpKMJjlXSXpBUKnlJRGRDLUcIj4=;
        b=bivHnfMvtadu3P5C43uIGZYPPcKDULWvoh5lB511EwQgvPKd0vUHySUp4BJ6bn6R75
         z1IxBVyRAsB4cBHcIaZ+APUHl5AjZ7HZZiuw3DzpU63pVCdOsNaFprqFzEK8GqLOxFuy
         C2LmpctKcOiDPxFU4ycOzx6RPEcA0G790oJhclMmfD0zDOsUarAkO/ACudJhUdKueUZ/
         DXBiN6V/lFjmBDS01FWfdqtoPtR/djljgsiW21ZOvPTHUgpWCTrx86dbSEoMTqHlxzCW
         UeoYoIKhAW6KcKUZ1MpvaP5kVUBaY6XiyEaBMBlbovzgaA4n+tBVyo8ndvAEJB6rBnG/
         swyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=ltdLotf7TOkPFkMNnpKMJjlXSXpBUKnlJRGRDLUcIj4=;
        b=4i8gIZYTxm7m3GXA1UEBbAF/eJXuUTzI0/MpjgIgkSvb5agIr/OSpBXu78C6VSYWGe
         UOyqJfsBFpriQkkTbzSbfEO6SNYqOU0C9ivn21H1rRTl3mUyyeLpSjRmACtuoNu56WeO
         b/DQ6lpw8APbdnqPzT5y1lD1L3HSsk9lpP+dlGhcGNUcu6dg/n4NnRSm7BA4+4xeMaom
         C62K50/i2LfySMMz2tUPf0VROSF/ljSVthjf0S3JAs03/wOX4D3aopE3YD/dug7WCytp
         7N0IT7Z3F/n1OrGcJnULVIBp3Dj2amK7iiB7GTA9QKSuW79hImPs+/WGadi0ueLnU+ID
         6CRg==
X-Gm-Message-State: AOAM533N0pN6qQy9154DUW/UPH45OUYEQSnrvSGQAWQexR6gdSIqdd0C
        9nedxas0RUQDHRRMAIL1d35bC0m882lus2l+wc4=
X-Google-Smtp-Source: ABdhPJwlUVOaWPmYa0+1vAGIBAZVCxZ6Q4IqDxqGWmbQzKbdKPgXFNsR5C1XSgGYeEM0lwn7p0P3+inidOcV2okPZAE=
X-Received: by 2002:a05:6402:4301:b0:427:c8e4:4acd with SMTP id
 m1-20020a056402430100b00427c8e44acdmr4342715edc.230.1651482338142; Mon, 02
 May 2022 02:05:38 -0700 (PDT)
MIME-Version: 1.0
Sender: reineyawoah@gmail.com
Received: by 2002:ab4:a70a:0:0:0:0:0 with HTTP; Mon, 2 May 2022 02:05:37 -0700 (PDT)
From:   Lila Lucas <lila69148@gmail.com>
Date:   Mon, 2 May 2022 11:05:37 +0200
X-Google-Sender-Auth: yo3cLrJh5UhWq-eNr9G8SKsBIFQ
Message-ID: <CAO0UoeMKUFqq4d6Drj3PGaoFdckWxSUeuBrsqinpkFszzZF3iQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=5.3 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52c listed in]
        [list.dnswl.org]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [reineyawoah[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  1.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Dear

I am glad to know you, but God knows you better and he knows why he
has directed me to you at this point in time so do not be surprised at
all. My name is Mrs.Lila Lucas, a widow, i have been suffering from
ovarian cancer disease. At this moment i am about to end the race like
this because the illness has gotten to a very bad stage, without any
family members and no child. I hope that you will not expose or betray
this trust and confidence that I am about to entrust to you for the
mutual benefit of the orphans and the less privileged ones. I have
some funds I inherited from my late husband,the sum of ($11.000.000
Eleven million dollars.) deposited in the Bank. Having known my
present health status, I decided to entrust this fund to you believing
that you will utilize it the way i am going to instruct
herein.Therefore I need you to assist me and reclaim this money and
use it for Charity works, for orphanages and giving justice and help
to the poor, needy and to promote the words of God and the effort that
the house of God will be maintained says The Lord." Jeremiah
22:15-16.=E2=80=9C

It will be my great pleasure to compensate you with 35 % percent of
the total money for your personal use, 5 % percent for any expenses
that may occur during the international transfer process while 60% of
the money will go to the charity project. All I require from you is
sincerity and the ability to complete God's task without any failure.
It will be my pleasure to see that the bank has finally released and
transferred the fund into your bank account therein your country even
before I die here in the hospital, because of my present health status
everything needs to be processed rapidly as soon as possible. Please
kindly respond quickly. Thanks and God bless you,

May God Bless you for your kind help.
Yours sincerely sister Mrs. Lila Lucas.
