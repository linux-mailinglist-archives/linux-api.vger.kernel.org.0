Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FFEA72EA86
	for <lists+linux-api@lfdr.de>; Tue, 13 Jun 2023 20:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjFMSHc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 13 Jun 2023 14:07:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjFMSHb (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 13 Jun 2023 14:07:31 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C1B19A7
        for <linux-api@vger.kernel.org>; Tue, 13 Jun 2023 11:07:30 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-514ab6cb529so13785007a12.1
        for <linux-api@vger.kernel.org>; Tue, 13 Jun 2023 11:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1686679648; x=1689271648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KU2BO0gcHFt44DuEFTAO2c7xYdpyPStn/nzoWP1HBD4=;
        b=M9e+tsL9gbG4uGafydsqUpSM6VXnr2PL6Kv7yMTM8DVMzJwffGl2v+bSpMfuDlktK1
         yLhRAtRhOqJZf9QAeaeTvSgpllaCh9u62B6rDlF5v00cjZn6vX8+MEuiZ0a4tvGXC1S7
         XYTA84lFwyG2ayBKUdKhIYPm4zSa4zNQYoylg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686679648; x=1689271648;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KU2BO0gcHFt44DuEFTAO2c7xYdpyPStn/nzoWP1HBD4=;
        b=Q757yEudaxjPn4nDSDhVHC6pL/K3gYnpE2auE41xCY6bTyIu4tkABVEG93iA35LoO/
         VZ9T+Eu54M+OWcFvvCsVI1EKOt8PIaaV781J3IGlJyUzyqlas2Zp/baSuRxDp+8TsgDZ
         Ib+gKoB7jRdyXqpY84Fj+nU57B+O7cVovlaT0ywrwKxThqKxGsKlassCyYs8EN21z7xo
         Uuq/F0MBlMc7Fk28QndKb4tckdFIggdSxqG8rvYDYhguSIvWHSG2YV+Umbaj8aVEFUG6
         jDjjfdEwNTRkvWJyFYQaeLRgnTvKI2YjhJVyvYzqg2aDERuIwUegea85frwk+8P/9TkY
         MRpw==
X-Gm-Message-State: AC+VfDxG/6bejx9HTnvP2gx5DGXPb7xkf/mhdcqIUvv0MxF4B/fQTB8l
        ZJhSiSUhc+0RBUWLpTo/KP3j/g+ANMf0H8D7liGdkuW+
X-Google-Smtp-Source: ACHHUZ5ZdsjkGLB/6Yu25j3SNQ0Pz1PjzSKoTrCoFgN6nnmJxV/ZYqKmlAHRdNNj9EvQfIzi1E1KHA==
X-Received: by 2002:a17:906:794b:b0:973:ddfe:e074 with SMTP id l11-20020a170906794b00b00973ddfee074mr13784576ejo.2.1686679648415;
        Tue, 13 Jun 2023 11:07:28 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id m25-20020a1709066d1900b00967a18df1easm6888950ejr.117.2023.06.13.11.07.27
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 11:07:28 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-51873d9a75dso2020690a12.1
        for <linux-api@vger.kernel.org>; Tue, 13 Jun 2023 11:07:27 -0700 (PDT)
X-Received: by 2002:a17:907:7d92:b0:969:9c0c:4c97 with SMTP id
 oz18-20020a1709077d9200b009699c0c4c97mr13719822ejc.1.1686679279617; Tue, 13
 Jun 2023 11:01:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com> <20230613001108.3040476-12-rick.p.edgecombe@intel.com>
In-Reply-To: <20230613001108.3040476-12-rick.p.edgecombe@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Jun 2023 11:01:02 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh-PfXhVb7Atk+G8SNjFSvqDWu37KPFR-ssuM-j_o93Kg@mail.gmail.com>
Message-ID: <CAHk-=wh-PfXhVb7Atk+G8SNjFSvqDWu37KPFR-ssuM-j_o93Kg@mail.gmail.com>
Subject: Re: [PATCH v9 11/42] x86/mm: Update ptep/pmdp_set_wrprotect() for _PAGE_SAVED_DIRTY
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

On Mon, Jun 12, 2023 at 5:14=E2=80=AFPM Rick Edgecombe
<rick.p.edgecombe@intel.com> wrote:
>
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1189,7 +1189,17 @@ static inline pte_t ptep_get_and_clear_full(struct=
 mm_struct *mm,
>  static inline void ptep_set_wrprotect(struct mm_struct *mm,
>                                       unsigned long addr, pte_t *ptep)
>  {
> -       clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
> +       /*
> +        * Avoid accidentally creating shadow stack PTEs
> +        * (Write=3D0,Dirty=3D1).  Use cmpxchg() to prevent races with
> +        * the hardware setting Dirty=3D1.
> +        */
> +       pte_t old_pte, new_pte;
> +
> +       old_pte =3D READ_ONCE(*ptep);
> +       do {
> +               new_pte =3D pte_wrprotect(old_pte);
> +       } while (!try_cmpxchg((long *)&ptep->pte, (long *)&old_pte, *(lon=
g *)&new_pte));
>  }

Thanks. Much nicer with this all being done just one way and no need
for ifdeffery on config options and runtime static branches.

                  Linus
