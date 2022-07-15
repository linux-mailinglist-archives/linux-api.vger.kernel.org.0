Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20DF575FEE
	for <lists+linux-api@lfdr.de>; Fri, 15 Jul 2022 13:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiGOLWB (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 15 Jul 2022 07:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiGOLWA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 15 Jul 2022 07:22:00 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5371087C1F
        for <linux-api@vger.kernel.org>; Fri, 15 Jul 2022 04:21:56 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-31bf3656517so43679047b3.12
        for <linux-api@vger.kernel.org>; Fri, 15 Jul 2022 04:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dkVxiAsXVQZWFloXZfDXz+TjjPPvSMh+ZOUwfV+rWAk=;
        b=na7fVRcOYydI6hUvM/LoPJ1er7GaajmqKsa/jaX6TgizoajoSoYFvE3Wv+wmzsUlg9
         kxHJigjvaz6R0elP/ugAKN0/1qPOfhS5xdlW8gKuxRfIyaCKaaqlEerGeJeVYTQ7JCEz
         mJHs4n1coq/pVT2m5hAvP9Piq1YJy79zZ0A/kXBR4gxSFr8yUXxr9zhSE8MKayIGzwH5
         PUrh/l+nQfqlGiZjmi8BUB3/PIOkazQSBK0K3sl4gI8O9S81N+BFseKGuUjjQdhGhYjz
         TsptIc6WrML00JUDyQJepFYEFqf5L70hyR5aXEE3h8abIkenXvOIiipIZmvhb8OCjIi7
         AzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dkVxiAsXVQZWFloXZfDXz+TjjPPvSMh+ZOUwfV+rWAk=;
        b=Q/0y24FnJYqTx4dKJPQTLt4DS/aEONp7f/ZNXFyWJdBQo1t9GN2UdJXPkM4e0Ksaxq
         moRbHfOMviI4we0ObJsMz5NXDqdZkO+0QCyZBl8MY6tP/4g64kSJyHnoM2Qd0t7SDu3B
         +TlGgCkFth3ngKddyoupnV5RuAchae7X/Quw61kCkoi4HtE1g/krp3EPET0pQ7pDYUDL
         BjGdm/6xpfvpU59g5j8xgzsB0Aee5+ehzJlbcjA18gNs4HIwF9NMKikm54S9iiV62pdN
         1CmI1XBAwUTgMNhoCuil0MqlCE/d61XMm0bvair45XC7h0uCA3yCH5hYHlUSiLh7xoTE
         lafA==
X-Gm-Message-State: AJIora+UFHCokZWmo6dOtfOWCSyWnKE3sj9M1poCdsF3rbb6kXVus+Px
        jxsPN57P3CPs1ywB9Fx4l7uFTp/b41QCi1TNTmulYQ==
X-Google-Smtp-Source: AGRyM1tUia74PMywhnQ5nJLObaGWCuXLa1QRTMd7+15WgJNNfZpSRMvZVm1YPqeRV6RTyyUcPAr/iSIvgM2jyRfhv3U=
X-Received: by 2002:a0d:dd09:0:b0:31c:e3b9:7442 with SMTP id
 g9-20020a0ddd09000000b0031ce3b97442mr15520622ywe.47.1657884115352; Fri, 15
 Jul 2022 04:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAB92dJbs0tcXmnQLZ5QKT4MJ+Hfbj4tr_HyFeaL=ySLHEUQxUQ@mail.gmail.com>
In-Reply-To: <CAB92dJbs0tcXmnQLZ5QKT4MJ+Hfbj4tr_HyFeaL=ySLHEUQxUQ@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 15 Jul 2022 13:21:44 +0200
Message-ID: <CANn89iJ0yB97TJ90MjuTx9UwuTKMM5qVgTaEhhwWboHOOb69Fg@mail.gmail.com>
Subject: Re: recvmmsg() behaviour with MSG_PEEK flag
To:     Alexander Babayants <babayants.alexander@gmail.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, mtk.manpages@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Fri, Jul 15, 2022 at 1:03 PM Alexander Babayants
<babayants.alexander@gmail.com> wrote:
>
> Hello!
>
> The behaviour of recvmmsg() with MSG_PEEK flag confuses me. I'd expect
> it to peek multiple messages at once, but it seems to peek only the
> first one, filling each of the provided struct msghdr with a copy of
> the first message. I do not see if it is documented anywhere, is it a
> bug or intended design?
>
> What I want to achieve is to first peek into the socket, get the size
> of each message, then allocate appropriate buffers and read the
> messages with the second recvmmsg() call. This seems to be a
> relatively common pattern for reading single messages via recvmsg(),
> and I naively expected it to work with recvmmsg() too.
>

MSG_PEEK is a mistake really, it considerably increases the cost of
receiving packets,
because you need twice more system calls.

It also increases costs in the kernel, having to deal with it, even if
not used by fast applications.

Adding proper MSG_PEEK support to recvmmsg() is tricky, do_recvmmsg()
would probably have
to be completely reimplemented to not call ___sys_recvmsg(), or risk
some quadratic behavior
if each ___sys_recvmsg() has to skip over N datagrams
