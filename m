Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A921B65C782
	for <lists+linux-api@lfdr.de>; Tue,  3 Jan 2023 20:27:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbjACT1P (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 3 Jan 2023 14:27:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239018AbjACT0s (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 3 Jan 2023 14:26:48 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B20196
        for <linux-api@vger.kernel.org>; Tue,  3 Jan 2023 11:26:46 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id u8so18506298ilq.13
        for <linux-api@vger.kernel.org>; Tue, 03 Jan 2023 11:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ia/lu5+B5CRXWa8CF3j1BLcFKSU3j2P6kHuicKKTwhM=;
        b=ZqWN8gFUfoVI5wnLUXnodqgP701dqeLd5CSt/RsefZ5Qkl5jGfXYOorD034HuIvB5D
         Ht8gtKf8KI4dn/azdfqIH5esBFN2+qILBHpfWUbepKnmZuifWK677ycRTg3al4Q+XtGT
         msE8MlX8P1FMZr6Yemo2KVXiq2CyfjHgRvf5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ia/lu5+B5CRXWa8CF3j1BLcFKSU3j2P6kHuicKKTwhM=;
        b=mIDOFT6XWbAl12xa2PERJzOAYmXTyt1EcPBccupl3D8WAhLxlMGMpjUvF2kyWBLI++
         8ZWmgDUf2U2bnZ9YocH/flW7EBZzQWajRQJBf5zuxmk0Okw3p8WjB9ADjizqUYHl0gyQ
         GQIIt+JduvzbD2ppxnlpe1210DXcWAz4BOgdK8kVMDzGLLh+piXrAwLaXgpTQmnVTvlS
         tMh0oummSVEa3GDw3t4hCT+p3+ZCxPZm5nfNBf8sm0yn4m0kZ0u6Te3DN9uw5QV0rhrT
         DeG0SDbee4caJPD93MQyaEea65YpwlyTvVsEistqXAU5c3bKe+RaEpU9o4PlGAsge1AM
         kHIA==
X-Gm-Message-State: AFqh2kq5Eyc1jGdpVMWpfdjYsjw3qFVlue/AHNB7rwrCdbBvYJKPn95/
        GCgY+YtcpO9lZK0LVlA/eeHWqqFnXBHblYba
X-Google-Smtp-Source: AMrXdXuRW2umyB7fRWan9reqZKW5FZVJR0LDxCy1RvVzE4cgis2cRHzfjyY0MRo9MvfGiRFQsivGGA==
X-Received: by 2002:a05:6e02:e05:b0:30c:21d5:5cdf with SMTP id a5-20020a056e020e0500b0030c21d55cdfmr13930508ilk.27.1672774005842;
        Tue, 03 Jan 2023 11:26:45 -0800 (PST)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id o186-20020a0222c3000000b0039e048ad8e7sm2933240jao.59.2023.01.03.11.26.45
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 11:26:45 -0800 (PST)
Received: by mail-io1-f49.google.com with SMTP id r72so17087868iod.5
        for <linux-api@vger.kernel.org>; Tue, 03 Jan 2023 11:26:45 -0800 (PST)
X-Received: by 2002:ac8:67da:0:b0:3a5:122:fb79 with SMTP id
 r26-20020ac867da000000b003a50122fb79mr1194253qtp.452.1672773592726; Tue, 03
 Jan 2023 11:19:52 -0800 (PST)
MIME-Version: 1.0
References: <20230101162910.710293-1-Jason@zx2c4.com> <20230101162910.710293-3-Jason@zx2c4.com>
 <Y7QIg/hAIk7eZE42@gmail.com> <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
In-Reply-To: <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 3 Jan 2023 11:19:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
Message-ID: <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tglx@linutronix.de, linux-crypto@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
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

On Tue, Jan 3, 2023 at 10:36 AM Andy Lutomirski <luto@kernel.org> wrote:
>
> I have a rather different suggestion: make a special mapping.  Jason,
> you're trying to shoehorn all kinds of bizarre behavior into the core
> mm, and none of that seems to me to belong to the core mm.  Instead,
> have an actual special mapping with callbacks that does the right
> thing.  No fancy VM flags.

I don't disagree, but honestly, my deeper reaction is "this is not worth it".

I think the real issue here is that Jason has to prove that this is
such a big deal that the VM has to be modified *at*all* for this.

Honestly, "getrandom()" performance simply is not important enough to
design VM changes for.

Do some people care? Debatable. Jason cares, sure. But people have
gotten used to doing their own random number implementations if they
*really* care, and yes, they've gotten them wrong, or they've not
performed as well as they could, but on the whole this is still a
really tiny thing, and Jason is trying to micro-optimize something
that THE KERNEL SHOULD NOT CARE ABOUT.

This should all be in libc. Not in the kernel with special magic vdso
support and special buffer allocations. The kernel should give good
enough support that libc can do a good job, but the kernel should
simply *not* take the approach of "libc will get this wrong, so let's
just do all the work for it".

Let user space do their own percpu areas if they really care. And most
(as in 99.9%) of all user space won't care at all, and is perfectly
happy just doing a read() from /dev/urandom or using our existing
"getrandom()" without any super-clever vdso support with magic
temporary buffer handling.

Now, if the magic buffers were something cool that were a generic
concept that a lot of *other* cases would also kill for, that's one
thing. But this is such a small special case that absolutely *nobody*
has asked for, and that nothing else wants.

             Linus
