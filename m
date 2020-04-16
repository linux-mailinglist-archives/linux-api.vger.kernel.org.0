Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 461C21AB968
	for <lists+linux-api@lfdr.de>; Thu, 16 Apr 2020 09:11:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437517AbgDPHKR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 16 Apr 2020 03:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437186AbgDPHKM (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 16 Apr 2020 03:10:12 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31FB3C061A0C;
        Thu, 16 Apr 2020 00:10:12 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a2so546909ejx.5;
        Thu, 16 Apr 2020 00:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=lO38k/X3AezDRtEd7sHEzvTIkXsx536sJgZXKd7j4Ps=;
        b=JLD9Do+bAmdzcUU3ZF97AYMRiak0lt4K5bGVkrvNlK2HYr0F7D2ljwQPLFmSARAjdq
         gvvo6gLdqqfWKEd23uklX0+C3q5e43eWUWg6W/1ry46hmeLv9RTqE86p+Ej4kl3F42eS
         lOKwONlWAzcg5LroQB0IPEL3oys2j/a9vyFH+6L5nmH/5npwZPtM2zahxqgUQpcE0Rln
         e5Cz8Evil3LykRZzextGs2xKozjuGMNG0F3xyU6PWq0xD37DrIRpAGA5ScjZ6y6DfRvd
         AwC3xn8Oa4IBZy3wI+U3EWfxfgWoIqAL/l5+yQCCh+N6Twf+AZpC2egeATembByd8wtG
         mR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=lO38k/X3AezDRtEd7sHEzvTIkXsx536sJgZXKd7j4Ps=;
        b=sr/1/jdBrE8KG3YYfWyLlTLb1oqFA+b88zaG/Z/pMnHABxusSONNUpR+e3G4fN2ElD
         crwXydD9O73KO7ZVffiY5xWFUYTQeM1p/Gfysm41g51hRwXDxMK2UGTf4j+kSibXmc2I
         OyKTfxP5YIVXjG923GwWrMo2wGtZ6JuuAQRzZ9a4H2ZBW0fRzjW7hbtrW7hElIqyv2sK
         +qxi/dZaWf6xMgx89FfhqhTbvJcmSe+qLgDzZVwIqma2pgFHViVfCz5fx5njwYhDOk40
         8WMu9WduqHo15gcNEGS7KEt7AGhRDaGWOrvBjL5jpIQqFkQqarkJX6nVFO1/Qcca8Nho
         P1OQ==
X-Gm-Message-State: AGi0Pubb//Ooph9cPuCBybZFLbrb9BF4CRXvYPf7eFg879weGWWb9/Q3
        hUP+VL5eRdJ2wumuxeemE9JODiKlABi+68cSxv8=
X-Google-Smtp-Source: APiQypLyted4Kkh6RxcxTxBO+iINrCeXM73sU7G62FZPta6vt7BDD+rwFPRgAcQUlYidZnzPpEIMtpTBo4xfd3jfqv8=
X-Received: by 2002:a17:906:704b:: with SMTP id r11mr8125482ejj.80.1587021010877;
 Thu, 16 Apr 2020 00:10:10 -0700 (PDT)
MIME-Version: 1.0
References: <96bedbaf-49ea-f24b-b7b1-fb9a57fb6c7d@gmail.com>
 <20200411154031.642557-1-avagin@gmail.com> <20200416065648.GA801745@gmail.com>
In-Reply-To: <20200416065648.GA801745@gmail.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 16 Apr 2020 09:10:00 +0200
Message-ID: <CAKgNAkhQhK5KxCtwqQ=V03kyCFPOxRGgT3ALnUFvHYzTtsn8Uw@mail.gmail.com>
Subject: Re: [PATCH v2] timens: show clock symbolic names in /proc/pid/timens_offsets
To:     Andrei Vagin <avagin@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Andrei,

On Thu, 16 Apr 2020 at 08:56, Andrei Vagin <avagin@gmail.com> wrote:
>
> On Sat, Apr 11, 2020 at 08:40:31AM -0700, Andrei Vagin wrote:
> > Michael Kerrisk suggested to replace numeric clock IDs on symbolic
> > names.
> >
> > Now the content of these files looks like this:
> > $ cat /proc/774/timens_offsets
> > monotonic      864000         0
> > boottime      1728000         0
> >
> > For setting offsets, both representations of clocks can be used.
> >
> > As for compatibility, it is acceptable to change things as long as
> > userspace doesn't care. The format of timens_offsets files is very
> > new and there are no userspace tools that rely on this format.
> >
> > But three projects crun, util-linux and criu rely on the interface of
> > setting time offsets and this is why we need to continue supporting the
> > clock IDs in this case.
> >
> > Fixes: 04a8682a71be ("fs/proc: Introduce /proc/pid/timens_offsets")
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Eric W. Biederman <ebiederm@xmission.com>
> > Cc: Dmitry Safonov <0x7f454c46@gmail.com>
> > Acked-by: Michael Kerrisk <mtk.manpages@gmail.com>
>
> Thomas and Andrew, could you merge this patch? I am sorry, I used the
> wrong subsystem prefix. Let me know if I need to send the third version
> of this patch.

This patch should also be marked for stable@.

Thanks,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
