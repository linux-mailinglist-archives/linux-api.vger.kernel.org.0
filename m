Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 766764EA459
	for <lists+linux-api@lfdr.de>; Tue, 29 Mar 2022 03:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbiC2BAR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Mar 2022 21:00:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiC2BAQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Mar 2022 21:00:16 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FAA593B0
        for <linux-api@vger.kernel.org>; Mon, 28 Mar 2022 17:58:33 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bq24so11733785lfb.5
        for <linux-api@vger.kernel.org>; Mon, 28 Mar 2022 17:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbT6csJp5gfPs56Yka3GMDExKyohstgFfA3vzHyoz4o=;
        b=hkrcPaaBthoDmVf0x8DqWOp3+DOMUUl364NXBBrlTr+MeObvVj9lA3H/mEfDVmF1jF
         xzadtY24nWv+DJGgoDKv8i38g+H++jeiOO8/nubtuxIxqyDnSfLFXwTvaXRAIFJejJrG
         dSSoHLZV2getqXXTmQOAjSfemMBtGEe7ripPs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbT6csJp5gfPs56Yka3GMDExKyohstgFfA3vzHyoz4o=;
        b=BRv76dZCRrSQzst24LEcmQ8xGiD8y/hUH8P6vuyC2vTicDyTdxh+UFclqmcpSIcoBU
         9+yJKO3I1DjDrFIlMhySJ7rxECHppq/1KJxRl8Z+07VH7gzUEK18LnjJVKLmoRkkpT3p
         jYWMFCToYpkcz5BSBGKRa3j5cJN3YY546NEjbdYjL+qdztwt5babvegHn+x9CetjMJGH
         bFeVdnu/3ZVKAeHyvPoNhT7g1PjLrDzZATJLW6ZfVxuyJz85w+6jGTIyUwFr84frM86I
         f9B/Okg8IIQ6QYpe8eoIi6OagMceY+32WGPXd1LQtgcCKC7RRGsF7out+SFQqiW2ZR9N
         ngQQ==
X-Gm-Message-State: AOAM533r9Ao/S4kgQhn2L1VCRBXZzU3Wqga1YNCG+wGZgjr1Lg/s8v3m
        RKhCdSNMN6ftGuaD+p8trG04hXkmceyVi21+
X-Google-Smtp-Source: ABdhPJwP3bAi3U5ySVc0BZWOQjnSMbCufRTAfeJoU0ee9RmJWulMb5Ufygdt5mOkDL9Mix9YOBnfnw==
X-Received: by 2002:a05:6512:3fa9:b0:44a:313e:eb63 with SMTP id x41-20020a0565123fa900b0044a313eeb63mr216969lfa.19.1648515511764;
        Mon, 28 Mar 2022 17:58:31 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id z6-20020a19e206000000b0044a7a4e6bd7sm1137800lfg.180.2022.03.28.17.58.30
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 17:58:30 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id h7so27703184lfl.2
        for <linux-api@vger.kernel.org>; Mon, 28 Mar 2022 17:58:30 -0700 (PDT)
X-Received: by 2002:a05:6512:2296:b0:44a:6aaf:b330 with SMTP id
 f22-20020a056512229600b0044a6aafb330mr199946lfu.531.1648515510085; Mon, 28
 Mar 2022 17:58:30 -0700 (PDT)
MIME-Version: 1.0
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <87bl1kunjj.fsf@email.froward.int.ebiederm.org> <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org> <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
 <87a6d9pr5t.fsf_-_@email.froward.int.ebiederm.org> <CAHk-=wj2u3MT5Ukaw9aAB-0oSs9S58kuRNqqy5AL-GTn9LNGkA@mail.gmail.com>
 <20220329115308.7388b656@canb.auug.org.au>
In-Reply-To: <20220329115308.7388b656@canb.auug.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Mar 2022 17:58:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=whB4V+XkVvsZmJ4j_K=QKMSj13vDYnVjY0R8fHUmGaF8w@mail.gmail.com>
Message-ID: <CAHk-=whB4V+XkVvsZmJ4j_K=QKMSj13vDYnVjY0R8fHUmGaF8w@mail.gmail.com>
Subject: Re: [GIT PULL] ptrace: Cleanups for v5.18
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux API <linux-api@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Mar 28, 2022 at 5:53 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> See https://lore.kernel.org/lkml/20220316165612.4f50faad@canb.auug.org.au/

Ok, so it was known, just not reported to me.

And the good news seems to be that at least there isn't anything
hiding elsewhere.

                Linus
