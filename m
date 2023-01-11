Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C831D665B05
	for <lists+linux-api@lfdr.de>; Wed, 11 Jan 2023 13:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229881AbjAKMIW (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 11 Jan 2023 07:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjAKMIK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 11 Jan 2023 07:08:10 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53EF13B
        for <linux-api@vger.kernel.org>; Wed, 11 Jan 2023 04:08:08 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id bp44so13645429qtb.0
        for <linux-api@vger.kernel.org>; Wed, 11 Jan 2023 04:08:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kmJ3yYULDZh/n/Ts/CIw+F5G8M6+xd7o3i732aR8bfU=;
        b=Huh5mGKh/5kG5fJLMYNPH7N0pSWybZghPelk0NUdJxECQjfmL+QRCFnkVZYZ4p+6iD
         U+QihvuYLnC/fu4YtVobiKMfwnj89zGyUkxMQNLkIvXiiPlansCrF7ZPHS4XRej3DbV6
         fdWAbhsdr/nCOV/rntZFIEmSK949BWpA3v5Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kmJ3yYULDZh/n/Ts/CIw+F5G8M6+xd7o3i732aR8bfU=;
        b=mVVxPp8Em5Pjd2j9jJQ1S2yosyiQwICkGh1vPBUTyT3Je5jT7jCj66/t+j2ytB2ATN
         EzunUT1Zsd6e2dreFO6i4rCWYKtd0QUzkOhy2xa8Rt00gBZpwGSI3Dum3rOySLKIqP/m
         KFTStHi17TCI/fd7DVDJmQEHhYYdI87Tk4TbNSDDeHVHIy+oi0Vzmi656lMHl6B1H5cr
         4wZC3H7/DUHql+cveW5YpfGewrQvqHpnbMWBxCTZUpFAAsLZ02hMbN+ceoFOfQDaRM9E
         GBs5JqLAH2naBDAYmd4tZvPJSHQ4+WEpUCs36KVjgAkBTwdy++rdWbchB6r9V75bgQ3f
         XtTA==
X-Gm-Message-State: AFqh2koWH7hcjChI+JY9PeQIz3MBjwBkjcK8EtfVUdUsfF36fzJllcxC
        FQSTwmuC3e/V27CRGunzxJeNo+NZBzgYhQOzkL0=
X-Google-Smtp-Source: AMrXdXujCTeebSoR+EnuB6rn7Yyc1nvdRzjQyJfd4R7G2kdyIvgiXSjH1N1IcjvsckSRUcoisn/fPg==
X-Received: by 2002:ac8:6601:0:b0:3af:c63b:8ecf with SMTP id c1-20020ac86601000000b003afc63b8ecfmr6415032qtp.65.1673438887713;
        Wed, 11 Jan 2023 04:08:07 -0800 (PST)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com. [209.85.160.173])
        by smtp.gmail.com with ESMTPSA id l12-20020ac8078c000000b003996aa171b9sm7337650qth.97.2023.01.11.04.08.06
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Jan 2023 04:08:07 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id j15so8049370qtv.4
        for <linux-api@vger.kernel.org>; Wed, 11 Jan 2023 04:08:06 -0800 (PST)
X-Received: by 2002:a05:622a:2598:b0:3ae:db1:185f with SMTP id
 cj24-20020a05622a259800b003ae0db1185fmr412604qtb.436.1673438886653; Wed, 11
 Jan 2023 04:08:06 -0800 (PST)
MIME-Version: 1.0
References: <20230101162910.710293-1-Jason@zx2c4.com> <20230101162910.710293-3-Jason@zx2c4.com>
 <Y7QIg/hAIk7eZE42@gmail.com> <CALCETrWdw5kxrtr4M7AkKYDOJEE1cU1wENWgmgOxn0rEJz4y3w@mail.gmail.com>
 <CAHk-=wg_6Uhkjy12Vq_hN6rQqGRP2nE15rkgiAo6Qay5aOeigg@mail.gmail.com>
 <Y7SDgtXayQCy6xT6@zx2c4.com> <CAHk-=whQdWFw+0eGttxsWBHZg1+uh=0MhxXYtvJGX4t9P1MgNw@mail.gmail.com>
 <874jt0kndq.fsf@oldenburg.str.redhat.com> <CAHk-=wg7vMC2VmSBdVw7EKV+7UDiftQEg3L+3Rc0rcjjfsvs5A@mail.gmail.com>
 <Y75k2KaDz2WdcXLk@sol.localdomain>
In-Reply-To: <Y75k2KaDz2WdcXLk@sol.localdomain>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 11 Jan 2023 06:07:50 -0600
X-Gmail-Original-Message-ID: <CAHk-=wga2A0T8a3L6KHPrxjShU5-m6t7t71RfHHLnFmA0__wtQ@mail.gmail.com>
Message-ID: <CAHk-=wga2A0T8a3L6KHPrxjShU5-m6t7t71RfHHLnFmA0__wtQ@mail.gmail.com>
Subject: Re: [PATCH v14 2/7] mm: add VM_DROPPABLE for designating always
 lazily freeable mappings
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, tglx@linutronix.de,
        linux-crypto@vger.kernel.org, linux-api@vger.kernel.org,
        x86@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org,
        mlichvar@redhat.com
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

On Wed, Jan 11, 2023 at 1:27 AM Eric Biggers <ebiggers@kernel.org> wrote:
>
> How would userspace decide when to reseed its CRNGs, then?

.. and that is relevant to all the VM discussions exactly why?

                Linus
