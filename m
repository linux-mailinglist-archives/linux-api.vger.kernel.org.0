Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE45A72EA2E
	for <lists+linux-api@lfdr.de>; Tue, 13 Jun 2023 19:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231836AbjFMRp2 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 13 Jun 2023 13:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjFMRp1 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Jun 2023 13:45:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF046101
        for <linux-api@vger.kernel.org>; Tue, 13 Jun 2023 10:45:23 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-977c89c47bdso1025961966b.2
        for <linux-api@vger.kernel.org>; Tue, 13 Jun 2023 10:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686678322; x=1689270322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kcOW2YayMm3xjw1cJ1qlGpr/UGWPmxOrQJ2QJLZKMzE=;
        b=gm3ycy8VIP9IYacuVuxZD/AZL1fZj7+ztkNwN3fDi6GgCGLM09PaHrih1/n7cDn3zz
         sFssXzZYfoSo+dBFhw+QyNZsCZ9DYwpzYecSoFWG1yDLRImga54Qlnxn22hDNBuWffBs
         Qp9xmgEVq6l16oCt+H6/vwj1MmQO6Pn63w+pA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686678322; x=1689270322;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kcOW2YayMm3xjw1cJ1qlGpr/UGWPmxOrQJ2QJLZKMzE=;
        b=AQlIqRTI5dDEfiOdNXFrVBr6XrcdiI7Yy+mHhxce8NuTAJtrXGSM4ifvWgHM2Uv4V8
         04IL/s5JiMZ0cVtefCgauxDnClebNNrTbIQ3lfQfkuyB462pqXEbXc/bqocQGSkH9tOd
         BNpqByjdEqPRD8ZJ6wx03zcDqFGR2OU12k8WACSo67mAWJodWNAM8zg9GjIitms8e71L
         BIvXfwuMIguiLtD9TcNLGfzboBm35kvYC7W2ilm+EaSC2ASCpW5xRettBAmTFrXXP+YH
         ibPdp4+FtgU3hxuXp7wsP1f2noSurZvytzkhtzYrPyeitRSyE5asBuuTmw3AsPiB8b9M
         mdDQ==
X-Gm-Message-State: AC+VfDxA4tVLEH6uX5qm+xocv1Wo1WdORQ/1YwDObbuGya2bIYjrRjQZ
        9IwPa9OYwhmeobe4/D7rbjGEC8v6Um8evjuFKN+UyeFu
X-Google-Smtp-Source: ACHHUZ6x9SJ85JYdDgX/vE6AXsjLEC5KqF9yoU4fm0BEwNPVp3h9GVIgsUls8K6YSqkK/D5FLCPHKQ==
X-Received: by 2002:a17:907:9413:b0:974:1d8b:ca5f with SMTP id dk19-20020a170907941300b009741d8bca5fmr14166446ejc.9.1686678322284;
        Tue, 13 Jun 2023 10:45:22 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id gv11-20020a170906f10b00b00947ed087a2csm6913525ejb.154.2023.06.13.10.45.21
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 10:45:22 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-977c89c47bdso1025959166b.2
        for <linux-api@vger.kernel.org>; Tue, 13 Jun 2023 10:45:21 -0700 (PDT)
X-Received: by 2002:a05:6512:548:b0:4ef:ec6a:198c with SMTP id
 h8-20020a056512054800b004efec6a198cmr6103911lfl.26.1686678301549; Tue, 13 Jun
 2023 10:45:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <CAHk-=wh0UNRn96k3XLh2AYOo0iz1k_Qk-rQXv8kYjXkKBzUMWA@mail.gmail.com> <c239d2c4f7e369690866db455813cac359731e1d.camel@intel.com>
In-Reply-To: <c239d2c4f7e369690866db455813cac359731e1d.camel@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Jun 2023 10:44:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjSWhVV+qr_tV0xg8c0WRn_H9wtFZkUVCpv-VzsddAS-Q@mail.gmail.com>
Message-ID: <CAHk-=wjSWhVV+qr_tV0xg8c0WRn_H9wtFZkUVCpv-VzsddAS-Q@mail.gmail.com>
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

On Mon, Jun 12, 2023 at 8:12=E2=80=AFPM Edgecombe, Rick P
<rick.p.edgecombe@intel.com> wrote:
>
> Sure. I probably should have included that upfront. Here is a github
> repo:
> https://github.com/rpedgeco/linux/tree/user_shstk_v9
>
> I went ahead and included the tags[0] from last time in case that's
> useful, but unfortunately the github web interface is not very
> conducive to viewing the tag-based segmentation of the series. If
> having it in a korg repo would be useful, please let me know.

Oh, kernel.org vs github doesn't matter. I'm not actually merging this
yet, I'm just doing a fetch to then easily be able to look at it
locally in different formats.

I tend to like seeing small things in my MUA just because then I don't
switch back-and-forth between reading email and some gitk workflow,
and it is easy to just scan through the series and reply all inthe
MUA.

But when it's some bigger piece, just doing a "git fetch" and then
being able to dissect it locally is really convenient.

Having worked with patches for three decades, I can read diffs in my
sleep - but it's still quite useful to say "give me the patches just
for *this* file" to just see how some specific area changed without
having to look at the other parts.

Or for example, that whole pte_mkwrite -> pte_mkwrite_novma patch is
much denser and more legible with color-coding and the --word-diff.

Anyway, I'm scanning through it right now. No comments yet, I only
just got started.

              Linus
