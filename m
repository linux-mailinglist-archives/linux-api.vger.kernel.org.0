Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A5C369118C
	for <lists+linux-api@lfdr.de>; Thu,  9 Feb 2023 20:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjBITs5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 9 Feb 2023 14:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjBITs4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 9 Feb 2023 14:48:56 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FB23663EE
        for <linux-api@vger.kernel.org>; Thu,  9 Feb 2023 11:48:54 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id dr8so9656738ejc.12
        for <linux-api@vger.kernel.org>; Thu, 09 Feb 2023 11:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uyyumaK9xIPRojo79Q77XEBPKCDiPO3uA+JJHpfAEgA=;
        b=AZFy9HZ53vfM3YDTX4dK7I32YlhT5/F/iQr2XxE+3tLHv580MbFNKnKBzBpuoX/slw
         PjfvwT6grUZ3pOe8wLygEzYEtv1brf6zchhh0beA9epwiFJouS5D4FAEx9mHBiCSfa2n
         6Hcp/yvPEzTW8cxxyAYGalExsZQLzgObV3DpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uyyumaK9xIPRojo79Q77XEBPKCDiPO3uA+JJHpfAEgA=;
        b=585Td+Dusj+Kc1VqdNvmSjGnEmxUNMdfUHOunYcO/S//Vi1/ZB1QBczGBnlh7EnDP5
         AnThOn6m566jGgctIKquC8Md5eecgX+zZoBCz5/t0qkQNEy/Dj0TtZTOt56NF5Az/e7j
         w8YIExEmBg/k8aPA51P8R7OhMsAffeFBPDci9l6QMHkoYKRJX3kLQxz6j0xfcYlCOuem
         GI9cXohdHNExBtc9ZvI4yngTpLzPelc0/T5IskRRI41rbyTlOO+rGEG5ieSlrzw3pOhG
         nKao21uQwLgTw99mYh4DMSBUyZTewoB6P1IVoHz9BM6aQy2tH8KMNC85qQs/ea8gnQ40
         V1tg==
X-Gm-Message-State: AO0yUKVazPMIWgiI15KN5loaLwmb3KxonWRayBfjsdPsVWajXIILO3jB
        WD78Cg+LwpRLoUNRwg8WyZeVABYu0iAnj8E1q3o=
X-Google-Smtp-Source: AK7set/xEVaspbbSBKN1+HcCajnJtgE1SWOeBhBeGDgwk86v/Z1EReMIuGxBxCMp4EdX324kaaGSSg==
X-Received: by 2002:a17:906:1d14:b0:88c:a43d:81bc with SMTP id n20-20020a1709061d1400b0088ca43d81bcmr12744373ejh.58.1675972132878;
        Thu, 09 Feb 2023 11:48:52 -0800 (PST)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id h24-20020a170906829800b008aa0305dbe8sm1250782ejx.80.2023.02.09.11.48.52
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 11:48:52 -0800 (PST)
Received: by mail-ej1-f47.google.com with SMTP id lu11so9760788ejb.3
        for <linux-api@vger.kernel.org>; Thu, 09 Feb 2023 11:48:52 -0800 (PST)
X-Received: by 2002:a17:906:4e46:b0:87a:7098:ca09 with SMTP id
 g6-20020a1709064e4600b0087a7098ca09mr2452063ejw.78.1675972132059; Thu, 09 Feb
 2023 11:48:52 -0800 (PST)
MIME-Version: 1.0
References: <0cfd9f02-dea7-90e2-e932-c8129b6013c7@samba.org>
 <CAHk-=wj8rthcQ9gQbvkMzeFt0iymq+CuOzmidx3Pm29Lg+W0gg@mail.gmail.com>
 <f6c6d42e-337a-bbab-0d36-cfcc915d26c6@samba.org> <CAHk-=widtNT9y-9uGMnAgyR0kzyo0XjTkExSMoGpbZgeU=+vng@mail.gmail.com>
In-Reply-To: <CAHk-=widtNT9y-9uGMnAgyR0kzyo0XjTkExSMoGpbZgeU=+vng@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Feb 2023 11:48:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=whprvcY=KRh15uqtmVqR2rL-H1yN6RaswHiWPsGHDqsSQ@mail.gmail.com>
Message-ID: <CAHk-=whprvcY=KRh15uqtmVqR2rL-H1yN6RaswHiWPsGHDqsSQ@mail.gmail.com>
Subject: Re: copy on write for splice() from file to pipe?
To:     Stefan Metzmacher <metze@samba.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Samba Technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Feb 9, 2023 at 11:36 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I guarantee that you will only slow things down with some odd async_memcpy.

Extended note: even if the copies themselves would then be done
concurrently with other work (so "not faster, but more parallel"), the
synchronization required at the end would then end up being costly
enough to eat up any possible win. Plus  you'd still end up with a
fundamental problem of "what if the data changes in the meantime".

And that's ignoring all the practical problems of actually starting
the async copy, which traditionally requires virtual to physical
translations (where "physical" is whatever the DMA address space is).

So I don't think there are any actual real cases of async memory copy
engines being even _remotely_ better than memcpy outside of
microcontrollers (and historical computers before caches - people may
still remember things like the Amiga blitter fondly).

Again, the exception ends up being if you can actually use real DMA to
not do a memory copy, but to transfer data directly to or from the
device. That's in some way what 'splice()' is designed to allow you to
do, but exactly by the pipe part ending up being the "conceptual
buffer" for the zero-copy pages.

So this is exactly *why* splicing from a file all the way to the
network will then show any file changes that have happened in between
that "splice started" and "network card got the data". You're supposed
to use splice only when you can guarantee the data stability (or,
alternatively, when you simply don't care about the data stability,
and getting the changed data is perfectly fine).

            Linus
