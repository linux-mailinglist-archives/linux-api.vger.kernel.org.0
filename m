Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142B172EA7C
	for <lists+linux-api@lfdr.de>; Tue, 13 Jun 2023 20:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229480AbjFMSFw (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 13 Jun 2023 14:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbjFMSFv (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Jun 2023 14:05:51 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6134419A7
        for <linux-api@vger.kernel.org>; Tue, 13 Jun 2023 11:05:48 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-977c72b116fso874819166b.3
        for <linux-api@vger.kernel.org>; Tue, 13 Jun 2023 11:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686679546; x=1689271546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u8Y88yptodPeuMRnHzLyyoqql+qi0tUT2B3rKlKiInQ=;
        b=bAI/PLg+gev2Lc16wQBqyw9KdYWQMQHjDjVQwasROQYSg8fwLt6fC4IQ57g1YsP3bl
         YdmnYqnlt88BkshbXhxQrOjPd7xOkJKrHDWcoxQeYG7rBQu9Gx7YHKwjoXXL7mHZIa7d
         tZ/v1Omm/fZ18AJabqeg8wGCRRW45Podc9Pic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686679546; x=1689271546;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u8Y88yptodPeuMRnHzLyyoqql+qi0tUT2B3rKlKiInQ=;
        b=OM9+1Uk9HQZ7XI+w0NT6aANYgYTm9STMz4rwXppjD3DR5KCWCjxnGLNWnMNw3b2GCB
         LR68qjEFa2pG/mTGBkO7Y42U5D4BUnQe13B0W81S2LWPBjjYeVTPo1XjkeKb/TUGdMN5
         m/C60ORWGrMv0YKRpjl+L1Z9df5gAlETZTXCIf0dJRgpkB9dMUZ/e4SrYgfiX906jFYy
         bVXDy8H6NgRx+yREmGGmqXZHjUzc+DMYJsaoi27dZwSt2IFRtwWhMbYybBfadVzbBp4u
         fwqbW/gBZVtr72mS5CJVqxNVTR2PokjjRYdjKhsk2zyyJVnO8qF5edf0VvdMtqWGmqXQ
         u4nA==
X-Gm-Message-State: AC+VfDzWI3Sqc91wYWf6ct/4yyVGs4pEeRB/FBZ2agx5uPUh6lM0FQ9C
        ZmvSkpZ2IRJeSS+l3hqlN/4vaAxDVsgRvodQvuv8TqUb
X-Google-Smtp-Source: ACHHUZ6Qe3y9gqFxNXpeICAIzJi7J917gfsWnJhfEK/jpkae51eHCWeH9YZ6qyUrxSoQnuV6JwfrNQ==
X-Received: by 2002:a17:906:da83:b0:974:1ced:6a59 with SMTP id xh3-20020a170906da8300b009741ced6a59mr12292880ejb.3.1686679546604;
        Tue, 13 Jun 2023 11:05:46 -0700 (PDT)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id jw19-20020a17090776b300b00973fac6065esm6854575ejc.223.2023.06.13.11.05.45
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:05:45 -0700 (PDT)
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-30e3caa6aa7so5772802f8f.1
        for <linux-api@vger.kernel.org>; Tue, 13 Jun 2023 11:05:45 -0700 (PDT)
X-Received: by 2002:adf:e546:0:b0:306:41d3:fcb9 with SMTP id
 z6-20020adfe546000000b0030641d3fcb9mr8013110wrm.27.1686679143465; Tue, 13 Jun
 2023 10:59:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com> <20230613001108.3040476-11-rick.p.edgecombe@intel.com>
In-Reply-To: <20230613001108.3040476-11-rick.p.edgecombe@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Jun 2023 10:58:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUz9BzHd7Ne1_bUa+4rWoTZanqkQvm4iJt=D7QpE3djw@mail.gmail.com>
Message-ID: <CAHk-=wgUz9BzHd7Ne1_bUa+4rWoTZanqkQvm4iJt=D7QpE3djw@mail.gmail.com>
Subject: Re: [PATCH v9 10/42] x86/mm: Introduce _PAGE_SAVED_DIRTY
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-api@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>,
        Borislav Petkov <bp@alien8.de>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Florian Weimer <fweimer@redhat.com>,
        "H . J . Lu" <hjl.tools@gmail.com>, Jann Horn <jannh@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Peter Zijlstra <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Weijiang Yang <weijiang.yang@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        John Allen <john.allen@amd.com>, kcc@google.com,
        eranian@google.com, rppt@kernel.org, jamorris@linux.microsoft.com,
        dethoma@microsoft.com, akpm@linux-foundation.org,
        Andrew.Cooper3@citrix.com, christina.schimpe@intel.com,
        david@redhat.com, debug@rivosinc.com, szabolcs.nagy@arm.com,
        broonie@kernel.org, Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Pengfei Xu <pengfei.xu@intel.com>
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

Small nit.

On Mon, Jun 12, 2023 at 5:14=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> +static inline unsigned long mksaveddirty_shift(unsigned long v)
> +{
> +       unsigned long cond =3D !(v & (1 << _PAGE_BIT_RW));
> +
> +       v |=3D ((v >> _PAGE_BIT_DIRTY) & cond) << _PAGE_BIT_SAVED_DIRTY;
> +       v &=3D ~(cond << _PAGE_BIT_DIRTY);

I assume you checked that the compiler does the right thing here?

Because the above is kind of an odd way to do things, I feel.

You use boolean operators and then work with an "unsigned long" and
then shift things by hand. So you're kind of mixing two different
mental models.

To me, it would be more natural to do that 'cond' calculation as

        unsigned long cond =3D (~v >> _PAGE_BIT_RW) & 1;

and keep everything in the "bitops" domain.

I suspect - and hope - that the compiler is smart enough to turn that
boolean test into just the shift, but if that's the intent, why not
just write it with that in mind and not have that "both ways" model?

> +static inline unsigned long clear_saveddirty_shift(unsigned long v)
> +{
> +       unsigned long cond =3D !!(v & (1 << _PAGE_BIT_RW));

Same comment here.

             Linus
