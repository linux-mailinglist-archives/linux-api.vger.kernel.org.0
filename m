Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90BCB51E0BF
	for <lists+linux-api@lfdr.de>; Fri,  6 May 2022 23:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiEFVMV (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 6 May 2022 17:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444288AbiEFVMU (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 6 May 2022 17:12:20 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F8C6F48F
        for <linux-api@vger.kernel.org>; Fri,  6 May 2022 14:08:35 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id q4so5700568plr.11
        for <linux-api@vger.kernel.org>; Fri, 06 May 2022 14:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=Joad3nP8B5ojFitfw8DdC0REQkC0zsEe5u5htQxRckBRMr0urz7hxKetQtkO7udZkC
         FzsX8+p0Sc9gNOdvrZeAW12+l5tyilxfYlspVMB2dpiDJXLqx6Wpi7hihMfrud54m1Zg
         Mh1oe2MDVYw6kiaDlA2NtogrCOZQSuzvqJYgf6f6Wy1ePNSkxUwDBI80KJ/ZXX/CFO5Q
         B0yfdN0Ec0SWIEutTTWh6w6dsvNIDRBHaB7bwrhudJECyVKeg6tf7u7bc9CBG2qQ5YWd
         PTVzliATz7YkJx+8OKJJ6ybkyR4ooOScuQpvU3MnF7L2YHjPQ0IF5hQRrxqJ19lmzvAD
         R+8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=VSSUIwdzgxQxnEkB7+u7pnweyPajIQMP3nQqWYs8VX0=;
        b=gTrhqs+2hAQik/zlaU5eWvoVbZMJYJbCWqeizC/M6wp++W83spcKcdAgdCEd3dWaw3
         5In7v2+FFaeNAHz+yx/D0WT1FBBEHIQnqcNvYJV9mJukq7cpKnlbB4YqGZ2RlkbGl/i8
         OW70pYzQA+n48vUGeSDy3ihpt8tjjcebBcbJpiJ4bBKWe54Q3B2TRFpOSLpKRQZc/fLA
         D+oksvgld9xbjbmG0rR27kDtTSjpN5+2fw/FJv4XdPwrAxN1XtI10M4TGStIGk7yqQ34
         FbjQH73f/YclDnHbdV4CKeFOtcv3R0Y0l+GF0Ialpl5GXN0XyNBFI5OTZrPVlblag/wJ
         ZYRQ==
X-Gm-Message-State: AOAM533KQHYJjDgQviCB1h6D1MKgQqy4JoX7pibo+qgFfJJMDmeY6+fi
        YSSwi5QwOaGWHHBnHLgUEIqjUUONHaqzFatRfg==
X-Google-Smtp-Source: ABdhPJx7AZjSp/7FT2MdvlO7YrWQYCt+JqbfUbd88+DVrBY7qXWtsKhZdbXg3BxxR2WqyNhrb0hZJ8rVXn/MQ9qyvow=
X-Received: by 2002:a17:90b:4c4d:b0:1dc:9636:ad19 with SMTP id
 np13-20020a17090b4c4d00b001dc9636ad19mr14608339pjb.39.1651871315438; Fri, 06
 May 2022 14:08:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac4:9906:0:b0:4ba:807b:b8f3 with HTTP; Fri, 6 May 2022
 14:08:34 -0700 (PDT)
Reply-To: warren001buffett@gmail.com
In-Reply-To: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
References: <CAD_xG_pvNZK6BFCW+28Xv4DE=_5rbDZXDok2BYNn9xw6Ma7iow@mail.gmail.com>
From:   Warren Buffett <guidayema@gmail.com>
Date:   Fri, 6 May 2022 21:08:34 +0000
Message-ID: <CAD_xG_rdOBPkJ_vBtwu64jvh_9gu-xQ0snv+DGiNbwhQ45dCoA@mail.gmail.com>
Subject: Fwd: My name is Warren Buffett, an American businessman.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:644 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4852]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [guidayema[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

My name is Warren Buffett, an American businessman and investor I have
something important to discuss with you.

Mr. Warren Buffett
warren001buffett@gmail.com
Chief Executive Officer: Berkshire Hathaway
aphy/Warren-Edward-Buffett
