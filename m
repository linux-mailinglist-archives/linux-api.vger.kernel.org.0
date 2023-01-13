Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CB3669A34
	for <lists+linux-api@lfdr.de>; Fri, 13 Jan 2023 15:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjAMObh (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 13 Jan 2023 09:31:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjAMOaw (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 13 Jan 2023 09:30:52 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B1B984BD1
        for <linux-api@vger.kernel.org>; Fri, 13 Jan 2023 06:23:56 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id m15so10862335ilq.2
        for <linux-api@vger.kernel.org>; Fri, 13 Jan 2023 06:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+OF3VMKCJX/ixRNA7KETCaEsWyEBkIDVOlKWye/O0OA=;
        b=JojvgH8XT/5W3Z19zz/xJpsK+UtUfuLOajrP2bUiE0PZHJLaHxyVoS/gdwZ4j1nINn
         NAhLjtRw5JWhWpQP6cjr/K+IqEq6cG/swjHmgKkU8/bzhvwyjyHr6pxRihWxyvWQ7jH/
         ycXHQba8H8CGw08mZc2lRnHbsatDyaP7XSi3luhnXRDyANgc7SfZsYR/2kBx67sDkelt
         N009oKtaqxMaVcV5I8bJGY2a5+MgMpNdeDc6P09VU6v2oJr8B0zV2O/YER8mJLD4Mn1g
         U9CLRknFXD87iaVRlJkboh6IHCCrAxvZm9BuL/cccG7OGvOaJ6fm9314ARdKvJNPjG9a
         t4ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+OF3VMKCJX/ixRNA7KETCaEsWyEBkIDVOlKWye/O0OA=;
        b=Ya9mxJP4qptKEskONUzLqAp59xK5Wu0MmKOsf27wfqkNZQSS9fPK2GqaBBQkjC7rts
         1oEN/KQEHwsK9ZeiVYOONGjTxgQXpBfcSuoncdL3Q/UeS6k0/tPHZs42Q0RiKrq1avvb
         U088OsHMF8yVsqPYTFKEUNdXQrgZ0fY89dbxhGXJaBA3uE6YtrL89DMAQVZaWaJj5aun
         GKuMb/OBFA1hBtxfGh76BvEEEySCuchyrmQdroK4M3s6eH0pqDTqqggcoafgk3wfC1Gl
         odvl6t1aGrof7+dur5TSxewZDMIp1UE4tqPnnUkri3cebe/KKSuwg8CpDP5t6qJFeLfV
         I9GA==
X-Gm-Message-State: AFqh2krx1UxGOlogjOulAU+1nVbr5qz+2tNGEQmJW4EwNCHOp7yp5cz2
        aJXeqZdfEmbgfMvY5e5Ll9fOLt9RpXUNeTtjBqM=
X-Google-Smtp-Source: AMrXdXszWXnZUU3mDwuG0prmaP86rTFSkz0+fra775veb5Y7HNHpZxCjxPfSPiWnLxbY0i6yMoRbzmb1JvPTG9uROSM=
X-Received: by 2002:a92:3601:0:b0:30e:e57f:b106 with SMTP id
 d1-20020a923601000000b0030ee57fb106mr115968ila.304.1673619835751; Fri, 13 Jan
 2023 06:23:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6e02:1282:b0:30d:c36b:403c with HTTP; Fri, 13 Jan 2023
 06:23:55 -0800 (PST)
Reply-To: hitnodeby23@yahoo.com
From:   Hinda Itno Deby <atidigahcyril@gmail.com>
Date:   Fri, 13 Jan 2023 06:23:55 -0800
Message-ID: <CALHvQ-jffHwgwQxY7MVBOpZpcQX1hUnBOishkcFBMPm+SMZxqA@mail.gmail.com>
Subject: Reply
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM,UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:12f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5029]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [hitnodeby23[at]yahoo.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [atidigahcyril[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.6 URG_BIZ Contains urgent matter
        *  2.7 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.7 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

-- 
My name is Hinda Itno Deby Please I want us to discuss Urgent Business
Proposal, if you are interested kindly reply to me so i can give you
all the details.

Thanks and God Bless You.
Ms Hinda Itno Deby
