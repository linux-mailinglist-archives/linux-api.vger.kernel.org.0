Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C01A18AE35
	for <lists+linux-api@lfdr.de>; Thu, 19 Mar 2020 09:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgCSIRC (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 19 Mar 2020 04:17:02 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:44423 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726188AbgCSIRC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 19 Mar 2020 04:17:02 -0400
Received: from mail-qv1-f51.google.com ([209.85.219.51]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1McYTD-1jrCVt0zEr-00d1a5; Thu, 19 Mar 2020 09:17:00 +0100
Received: by mail-qv1-f51.google.com with SMTP id m2so521131qvu.13;
        Thu, 19 Mar 2020 01:16:59 -0700 (PDT)
X-Gm-Message-State: ANhLgQ0MVelGgW9A3MfvnGDpwvgy/q3TmjsMOevt+oecnwlxFWjRnB42
        S2dt40Ltn611sWKE3JcZ0xOBrnCpl0YPQKwj11E=
X-Google-Smtp-Source: ADFU+vuvKhUMl9cghqMNKDgltUnhMBNGvVioHmVN2q91+1Ohn7tJEKoVYrbxquHMp8plMgeR0wZ5Qdf0EE9j967FD70=
X-Received: by 2002:a0c:f647:: with SMTP id s7mr1832971qvm.4.1584605819082;
 Thu, 19 Mar 2020 01:16:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200317083043.226593-1-areber@redhat.com> <CAK8P3a2-qQhpRdF0+iVrpp=vEvgwtndQL89CUm_QzoW2QYX1Jw@mail.gmail.com>
 <20200319081137.GC223854@dcbz.redhat.com>
In-Reply-To: <20200319081137.GC223854@dcbz.redhat.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 19 Mar 2020 09:16:43 +0100
X-Gmail-Original-Message-ID: <CAK8P3a18YySozk6P77JpS58Hbtz=QQmLKw+PrzXbdOwtOQQuJA@mail.gmail.com>
Message-ID: <CAK8P3a18YySozk6P77JpS58Hbtz=QQmLKw+PrzXbdOwtOQQuJA@mail.gmail.com>
Subject: Re: clone3: allow creation of time namespace with offset
To:     Adrian Reber <areber@redhat.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Pavel Emelyanov <ovzxemul@gmail.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Radostin Stoyanov <rstoyanov1@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:+GajmnIHBBfa+wnucP62mdW4D0KSk3X5HuJXrapNIX2Pm0HqAVy
 T87l3rzDqMJGdaKHogrdbdIQt1FedsI0goItnZky84ZVHXfyVgIRphy0cvutrqaJdHwR2Lq
 J4nGDaDDzHubPhv3M+tkbunOd9knDvrVo17G0WDWm0R6olNu1fvJoGtoupP72UZrT7x6kmx
 z0jDx9T6khcAMNV4uYXrA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:7gdf/FqWgSE=:+/s7qhnV4QaCD2FzAuaFxm
 AAzFdbtxiGhn3PfwVUkXVqErzqPBt1nCWXxLC6/dG/HEhlIuclDxnKBnp90P0T83YXEskcShF
 xpnA4cdNCerXyT0XinKAAUYpNdgSjToQMLGyBC6n2zSskwFXIFepnWv3PsjrFagkY/Ku92A/d
 +voIvYfG8V48sV2dhpz1iwB8iIq3ionPsb9BcHbE/1af/0mB2WiBrWVhZH1gCUVvACMdqTQjA
 FA3UIfh8Bw0ml98bjDzOB8YW1jdsTnNEdq+aAlTpjWywDBWpIQqovpxlUBb0P4KEJ3wc4B1Bv
 h3LafyAGrgVem/ZX/Dhhvlfdk83uWEvfwG2dhudSaPgeZDQSc2WSNTXwc25zQOg/f9V9bHUIO
 JAMwJFtfTJCOJ5plvCpvZEJ4On1+xo2JHXDI2E8dX2zkhzJ5IwVLxQtvGPw3FRvwXCxBrh8G+
 nBBj1oExdaVCZpbOtsnc/vlIxLCi+ItpPvlkggYqEh80pnSvSbK3ZltUWH7oCKEDo6/hdt4Lc
 0yzDyt963QBwJiSD1P8aEwCELs4zbX0/D9/ptpKTS2TkcBuI7bZPxMAYxdbpSWm2+9IMZrTTc
 Qhgi+iQIDXEGi+GzuJtjKrqtttldpL9dJUsno4OWjWqBNu9JKk3uKI51OCDCzM55KWwuLsWTc
 9PIiLkjxAUgt3OGefT4G/mQFcsKTiGQuTNBEDtosEdmTxQlSR+B4NcCs9fw0v04B32RZKF7+Z
 sZAC9iDdc+snPBf0IZH+s9VhxEP3OBbWT9yYvPr5PAXbotkWQwGqCqtBhTlgyHzrLmOWYcr1N
 TjyeKOjT2HmzRG82yScyt/oAeT70A0+PgRnh4VsSlj7mAj4Yks=
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Mar 19, 2020 at 9:11 AM Adrian Reber <areber@redhat.com> wrote:

> With Arnd's idea of only using nanoseconds, timens_offset would then
> contain something like this:
>
> struct timens_offset {
>         __aligned_s64 monotonic_offset_ns;
>         __aligned_s64 boottime_offset_ns;
> };
>
> I kind of prefer adding boottime and monotonic directly to struct clone_args
>
>         __aligned_u64 tls;
>         __aligned_u64 set_tid;
>         __aligned_u64 set_tid_size;
> +       __aligned_s64 monotonic_offset_ns;
> +       __aligned_s64 boottime_offset_ns;
>  };

I would also prefer the second approach using two 64-bit integers
instead of a pointer, as it keeps the interface simpler to implement
and simpler to interpret by other tools.

      Arnd
