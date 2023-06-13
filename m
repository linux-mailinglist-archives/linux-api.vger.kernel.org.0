Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1522672EB12
	for <lists+linux-api@lfdr.de>; Tue, 13 Jun 2023 20:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbjFMSgJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 13 Jun 2023 14:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240112AbjFMSgI (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Jun 2023 14:36:08 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B731BD3
        for <linux-api@vger.kernel.org>; Tue, 13 Jun 2023 11:36:05 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-5184abe9e86so2782252a12.0
        for <linux-api@vger.kernel.org>; Tue, 13 Jun 2023 11:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686681364; x=1689273364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c13OqGThZo2X78u4bO5FLqEGNspfbVSXUjccgWtSHTY=;
        b=ANE/1RdrK0/uJ1d5u1IF7bwC3IYLTZ+W1qlyDzVTjdfogmY4e8wJqRj5EirxvjDfcs
         upZ5wa0jrZsBIhIPTwkBHkixnCO2mwhmJGfShW2G3Xs6wiDN1tXPIo7dYNAhD6hWsvZO
         1e/VGLpglNr4Cp8rsiGoX4CsQDVS0yKCj6gvs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686681364; x=1689273364;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c13OqGThZo2X78u4bO5FLqEGNspfbVSXUjccgWtSHTY=;
        b=eDenFwJVZgn95RN8CwPYUuY6aC+s8x6N7yS3W69bGAFJwBOpbZuYIMgDq6ASnWK3Xw
         4Rv4DUrbTVEEf0XVrjFWteU9BYUxwqXeBMWCQi+3XvBmtwLuNNNwoFTlXFN1oyvivU9P
         8stjHyAktY6HxCvcJoZE1tuf25zmYEsPOZzAlnGrVD1xKoRSsMhN1bzGJ8h73rFMZbSA
         cFxHJKtlDo4a2u9/mP2HC3oJKhcb8nb/5K+JzqumT5dY7ukCCl9a+7ltfV2EKMddBMVO
         ttypCP/rdotA0I73pJYnyML7xIGNv85tb+7mOfXdllFZV6MpDIkJgnbithiUqftSUfsx
         2m9w==
X-Gm-Message-State: AC+VfDzy+sxWnM5PmgT1jCBsk4sCchHMp4HVkCRBSwkk9wIa4VYakaPc
        Y3MNQlT6smQHhnQLiJhSjaPvu2moofIhnQJHcjUzX9U1
X-Google-Smtp-Source: ACHHUZ54I3MJF82t3b/LvkdXh0UmQ99yhzBibJ7VByuzNFhb3b8zaYXYXjO+UPX6AfdlyJR/xVzJuw==
X-Received: by 2002:a17:907:787:b0:970:71c:df58 with SMTP id xd7-20020a170907078700b00970071cdf58mr12580655ejb.42.1686681364253;
        Tue, 13 Jun 2023 11:36:04 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id f21-20020a170906139500b009745482c5b7sm6955801ejc.94.2023.06.13.11.36.03
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:36:03 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-51870e2dc48so1962796a12.1
        for <linux-api@vger.kernel.org>; Tue, 13 Jun 2023 11:36:03 -0700 (PDT)
X-Received: by 2002:a19:3819:0:b0:4f7:457e:a457 with SMTP id
 f25-20020a193819000000b004f7457ea457mr3476722lfa.53.1686680882933; Tue, 13
 Jun 2023 11:28:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <CAHk-=wh0UNRn96k3XLh2AYOo0iz1k_Qk-rQXv8kYjXkKBzUMWA@mail.gmail.com>
 <c239d2c4f7e369690866db455813cac359731e1d.camel@intel.com> <CAHk-=wjSWhVV+qr_tV0xg8c0WRn_H9wtFZkUVCpv-VzsddAS-Q@mail.gmail.com>
In-Reply-To: <CAHk-=wjSWhVV+qr_tV0xg8c0WRn_H9wtFZkUVCpv-VzsddAS-Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Jun 2023 11:27:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=whY0ggV9P+3Ch1LcqefnS3=O7FmWkOPoiABD7QJGtwSHg@mail.gmail.com>
Message-ID: <CAHk-=whY0ggV9P+3Ch1LcqefnS3=O7FmWkOPoiABD7QJGtwSHg@mail.gmail.com>
Subject: Re: [PATCH v9 00/42] Shadow stacks for userspace
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "david@redhat.com" <david@redhat.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Jun 13, 2023 at 10:44=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Anyway, I'm scanning through it right now. No comments yet, I only
> just got started.

Well, it all looked fine from a quick scan. One small comment, and
even that was just a minor stylistic nit.

I didn't actually look through the x86 state infrastructure side -
I'll just trust that is fine, and it doesn't interact with anything
else, so I don't really worry about it. I mainly care about the VM
side not causing problems, and the changes on that side all looked
fine.

             Linus
