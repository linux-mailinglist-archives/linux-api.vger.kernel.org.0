Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45C4262161B
	for <lists+linux-api@lfdr.de>; Tue,  8 Nov 2022 15:22:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233968AbiKHOWq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 8 Nov 2022 09:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbiKHOWP (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 8 Nov 2022 09:22:15 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74CE854B20
        for <linux-api@vger.kernel.org>; Tue,  8 Nov 2022 06:22:14 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id n12so38934063eja.11
        for <linux-api@vger.kernel.org>; Tue, 08 Nov 2022 06:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=jSc0NsQQnXAyfyqUSZKDYzahyhZz76E4rHtd1pE51SxxJXT4eloDHBPPzfL4l0WO9W
         Zy0eD/wdi9YvuhhZVh71lpB+gRMRflSPleKA2AqutM0QAeQUK7ne3Wj+qhZGFmVtiAA2
         GSrXNpoVvtsC6jiqhPzbKbOxpLZXG9YkEkJfwfQ1jAoKxSY/UanwvITnEYykxoswTSRy
         35KlXeZohejq4A/oSAVKeQAaZZzRsWYDHxrMVdsEUd0sKhH4dLM9jfMRv4UXezOMWm+s
         HDMUKfY1jNVl5iOHIvGfVew7yvON7Ho70PVLOILpaxG9deCgI2iCdTKd4QljfXyGnom+
         kYbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=wJTPd/Xt9Hsp+l4/QbS4dbCN/HNNFjlZCtChfu2i1F6wVdans/8ayx1eigKyjbVVrE
         kBZXEXxY55Bxh8tWWwzIRHBMdZieseTkMeR+lqOger3VVgBN3o6NuRZjvQA5scyPbbs5
         XhPSnntYX8K0Retvl+s9dkuC8DiL3MYHE2AoA91TFwPa0RoF/o1q7XMQN5QCsyLmZVnY
         Cw5Bws7nY+XtDZkPVsHD95P9UxehvU3SswRrVi5XopNjXWYdtJP4fhSqtGDBsekQVXsJ
         mY9uOPK4Lxd93KgJjYY+8ive5anNHBZAimTvscg5wyg7FL5CEncf9PCjwlga+r8yACgx
         vzYw==
X-Gm-Message-State: ACrzQf3IGTe2s3bMVm255SDJruwQnArJ4QPqtMisWQb8qy41pmcvGyYl
        Ib5IKh7xqENxoj8aR53TnhRvDk8SIIFpT6ZN4lc=
X-Google-Smtp-Source: AMsMyM70nlaS3Y1LyS3bDYm9icHloC5/nVvOpGiPirMzidxMQyxx2Vh+YRH4/uqxcekytNlLIQPSbkHiQzrLo6nGTu8=
X-Received: by 2002:a17:907:c08:b0:7ad:f758:2899 with SMTP id
 ga8-20020a1709070c0800b007adf7582899mr35587413ejc.671.1667917332806; Tue, 08
 Nov 2022 06:22:12 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6402:3514:b0:462:e787:e7e with HTTP; Tue, 8 Nov 2022
 06:22:11 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <davidkekeli4@gmail.com>
Date:   Tue, 8 Nov 2022 14:22:11 +0000
Message-ID: <CAO+ex-UZzNgvtEnUjU-Qr2vXws1D3nSaYaxbZRGFW8g0scgnvA@mail.gmail.com>
Subject: Greeting
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:632 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4720]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [mr.abraham022[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [davidkekeli4[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [davidkekeli4[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
