Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E9165F96A
	for <lists+linux-api@lfdr.de>; Fri,  6 Jan 2023 03:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbjAFCIt (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Jan 2023 21:08:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjAFCIs (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Jan 2023 21:08:48 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C75AC6146F
        for <linux-api@vger.kernel.org>; Thu,  5 Jan 2023 18:08:47 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id h26so1113310qtu.2
        for <linux-api@vger.kernel.org>; Thu, 05 Jan 2023 18:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BiZr/M2mt9gUTQKPQ4MQC9Idh91qUV736LW/CBudrbE=;
        b=P6XRZRqc9dOjMMfEouyKdDiSj6G0ngTgOdZFQGSK75nkXucj9HkSaMYockndHF8Fgv
         JpamW/mn6TTZlF+lr+0GH7uDfMqIljr7VdSxGTydv+v+N5EB1KGXMLstsXEyad+KVLek
         0ijEMujzD3TCNaC+kW7hIIfLR7gJwBPXI08m0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BiZr/M2mt9gUTQKPQ4MQC9Idh91qUV736LW/CBudrbE=;
        b=db58Sr0QVFgN+jnWymuzyDp85oPHOPZpXu2twM2uQHN0KoW5tpT/Fvkg0uZmWGuDt5
         hp2i06y0jAf3cXSY6ZT1+WvaXnMBDkxgdJVSvCW9ODyl+rh6QteOCmTUIauCvDno5/ZT
         q3j4u2hklVjVuMQFcvPtvLeSGvXiqYufxQONpWDSRLhN2/hVjiCOST0S0gjC5nTzsKz+
         wogVogVM3rpDYrwvlMzUddiJ6Mdnlg1rUId90eWg9r7DHVqDpmLMwfrOCsSchSu1+K8N
         eejxF2TIvaNezZrchr4Ne80VTvbMU1pw4wv9fzZQ3Ccci1PNMMey/SQNcX5p3JchkTe5
         e8Qg==
X-Gm-Message-State: AFqh2koFte+3a+wZEmQHdMjnd1tlJk/XU3viprzWCDQNkdmwK/KkzUss
        wb9o0l7gxCrKlqCdNGoTZNKD8z+6w1KCD9IP
X-Google-Smtp-Source: AMrXdXtrGqAuHi/h8tY5pquQma7Lyfk1fssUlUQ1Cr1T19SPwgiDrggPR8t+CsoL6ad0Fc9CXhk4sA==
X-Received: by 2002:a05:622a:1f17:b0:3a9:8370:63d4 with SMTP id ca23-20020a05622a1f1700b003a9837063d4mr91458057qtb.42.1672970926490;
        Thu, 05 Jan 2023 18:08:46 -0800 (PST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id n2-20020a05620a294200b006faaf6dc55asm27070033qkp.22.2023.01.05.18.08.45
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 18:08:45 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id c11so975902qtn.11
        for <linux-api@vger.kernel.org>; Thu, 05 Jan 2023 18:08:45 -0800 (PST)
X-Received: by 2002:a05:622a:428c:b0:3a6:8b84:47ce with SMTP id
 cr12-20020a05622a428c00b003a68b8447cemr1471748qtb.678.1672970924763; Thu, 05
 Jan 2023 18:08:44 -0800 (PST)
MIME-Version: 1.0
References: <20230101162910.710293-3-Jason@zx2c4.com> <Y7QIg/hAIk7eZE42@gmail.com>
 <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
 <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
 <Y7SDgtXayQCy6xT6@zx2c4.com> <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
 <Y7SJ+/axonTK0Fir@zx2c4.com> <CAHk-=wi4gshfKjbhEO_xZdVb9ztXf0iuv5kKhxtvAHf2HzTmng@mail.gmail.com>
 <Y7STv9+p248zr+0a@zx2c4.com> <10302240-51ec-0854-2c86-16752d67a9be@opteya.com>
 <Y7dV1lVUYjqs8fh0@zx2c4.com> <CAHk-=wijEC_oDzfUajhmp=ZVnzMTXgjxHEcxAfaHiNQm4iAcqA@mail.gmail.com>
In-Reply-To: <CAHk-=wijEC_oDzfUajhmp=ZVnzMTXgjxHEcxAfaHiNQm4iAcqA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 5 Jan 2023 18:08:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiO4rp8oVmj6i6vvC97gNePLN-SxhSK=UozA88G6nxBGQ@mail.gmail.com>
Message-ID: <CAHk-=wiO4rp8oVmj6i6vvC97gNePLN-SxhSK=UozA88G6nxBGQ@mail.gmail.com>
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Yann Droneaud <ydroneaud@opteya.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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

On Thu, Jan 5, 2023 at 5:02 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> None of what you ask for is for any kind of real security, it's all
> just crazy "but I want to feel the warm and fuzzies and take shortcuts
> elsewhere, and push my pain onto other people".

Actually, let me maybe soften that a bit and say that it's
"convenience features". It might make some things more _convenient_ to
do, exactly because it might allow other parts to do short-cuts.

But because it's a convenience-feature, it had also better either be
(a) really easy and clear to do in the kernel and (b) have
sufficiently *wide* convenience so that it doesn't end up being one of
those "corner case things we have to maintain forever and nobody
uses".

And I think VM_DROPPABLE matches (a), and would be fine if it had some
other non-made-up use (although honestly, we should solve the 32-bit
problem first - ignoring it isn't fine for anything that is supposed
to be widely useful).

We *have* talked about features kind of like it before, for people
doing basically caches in user space that they can re-create on demand
and are ok with just going away under memory pressure.

But those people almost invariably want dropped pages to cause a
SIGSEGV or SIGBUS, not to come back as zeroes.

So you were insulting when you said kernel people don't care about
security issues.  And I'm just telling you that's not true, but it
*is* 100% true that kernel people are often really fed up with
security people who have their blinders on, focus on some small thing,
and think nothing else ever matters.

So yes, the way to get something like VM_DROPPABLE accepted is to
remove the blinders, and have it be something more widely useful, and
not be a "for made up bad code".

Side note: making the 32-bit issue go away is likely trivial. We can
make 'vm_flags' be 64-bit, and a patch for that has been floating
around for over a decade:

   https://lore.kernel.org/all/20110412151116.B50D.A69D9226@jp.fujitsu.com/

but there was enough push-back on that patch that I didn't want to
take it, and some of the arguments for it were not that convincing (at
the time).

But see commit ca16d140af91 ("mm: don't access vm_flags as 'int'"),
which happened as a result, and which I (obviously very naively)
believed would be a way to get the conversion to happen in a more
controlled manner. Sadly, it never actually took off, and we have very
few "vm_flags_t" users in the kernel, and a lot of "unsigned long
flags". We even started out with a "__nocast" annotation to try to
make sparse trigger on people who didn't use vm_flags_t properly. That
was removed due to it just never happening.

But converting things to vm_flags_t with a coccinelle script
(hand-wave: look for variables of of "unsigned long" that use the
VM_xyz constants), and then just making vm_flags_t be a "u64" instead
sounds like a way forward.

But again: this is all about new flags like VM_DROPPABLE not being
some corner-case that nobody is expected to use other than some
special code that is relegated to 64-bit only because it is *so*
special.

                 Linus
