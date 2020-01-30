Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 008D114DC97
	for <lists+linux-api@lfdr.de>; Thu, 30 Jan 2020 15:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgA3ONA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 30 Jan 2020 09:13:00 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46149 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbgA3ONA (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 30 Jan 2020 09:13:00 -0500
Received: by mail-lj1-f196.google.com with SMTP id x14so3452492ljd.13
        for <linux-api@vger.kernel.org>; Thu, 30 Jan 2020 06:12:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=mTLhSfziAL6vpXWHI78XNlGyf21af8hzO5XoOPYEOhE=;
        b=KA++3SC+eqLUMRc8qDtgBlIddKqEYBRdDEWMlzvHr25waadjtH9zXYzlieZQyqWSqX
         CQK+ovJpka8tlfNe1Xxs+92/9Q3O6e8FqTjRj2DOIzLJwq7U/m5G+2ouW1RI2OTjKViF
         PE12hkV7jkg/uZCXMucbJLC7tSnkZ/oFyaJBi4wi5BUE6LvtfGjTDl2S9ZpFsboXEA38
         N0sCyTh7rWVsS9a6i+V5ntMoz5tNDNU3oLutDXaoSGNkLoENf3BOiPuvGOJXrJR+7L+n
         LGSRVHxTaUIezrXGhHnx9Evi7L9FE77lT7LcTyIOb3FuFGOvPjmabKp1ckFMxS/Opo4g
         8TcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=mTLhSfziAL6vpXWHI78XNlGyf21af8hzO5XoOPYEOhE=;
        b=oTgiEsNvoVpwcNTPrImwBsgVxyquXUDvZMHrOv0l8WHfHfAXOfaE3wiLv+mJ/if+4N
         nV33vLpSeWz5CluCMIIfXBlFYJAGvi4m+rPhCI2iR+VWKxjxCKPfxcE0Y+LOnR/U3wgh
         tyfO5hYGEzYyJkqGroksr9jLkwlVdmw/lWMhVMWHLXuR8iWVsKpuCumadICxcRg78M3J
         ns9xEJQj7OvaD75zT5cQ2+QHLG8metGig5koEMRHsJhm375aKaNCORkvqELuWO0pncTE
         8guMlxplNF9E9QzamkYf1mGyjCWHXISZkS0GDkZOt8ROZzu5Skdu/Xc2wRzxOAdShz5L
         Pvpw==
X-Gm-Message-State: APjAAAWtw9zIVui7BeKQsD9zBeN90T6cygXb66HXx8BFcJa24/oJ5JBJ
        Tnf/PCcrLbIgspfhxFRDg8Pmk2g0QY2cDYWycQ+/0+KGtjo=
X-Google-Smtp-Source: APXvYqzsRX6b4+j7Q2vbpZ8rrvO5YN5tEfEuTwS7cC2KY3Za+hcJxNTZIJXFgho2brq1BVRD2lM6FV7GUBWZIAO62zw=
X-Received: by 2002:a2e:a490:: with SMTP id h16mr2984488lji.115.1580393577669;
 Thu, 30 Jan 2020 06:12:57 -0800 (PST)
MIME-Version: 1.0
References: <CALN7hC+f+D8xsaJBt+MCXDfk51oHCoQeUVmFydNdkW+_DeqTiw@mail.gmail.com>
 <88ab5e38-254a-430d-67cf-1840b0e51c35@redhat.com>
In-Reply-To: <88ab5e38-254a-430d-67cf-1840b0e51c35@redhat.com>
From:   Elichai Turkel <elichai.turkel@gmail.com>
Date:   Thu, 30 Jan 2020 16:12:31 +0200
Message-ID: <CALN7hCKre=Fkp35UAN_ao09yGwk4uMxpt9NpGHaHt2yXZFzvow@mail.gmail.com>
Subject: Re: Including both linux/time.h and linux/input.h causes failure
To:     linux-api@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Mostly I need the uid_t type for syscalls(getuid/setuid)
Which is defined in sys/types.h but that header also includes time
related stuff.

For context I'm writing a libc equivilant library (in rust).

Thanks,
Elichai.

On Wed, Jan 29, 2020 at 7:16 PM Carlos O'Donell <codonell@redhat.com> wrote:
>
> On 1/29/20 10:14 AM, Elichai Turkel wrote:
> > Hi,
> > The following header: <wrapper.h>:
> > ```
> > #include <linux/input.h>
> > #include <linux/time.h>
> > ```
> > Will cause the compiler to fail because of redefinition of a lot of
> > time related structs, that are declared once in `linux/time.h` and
> > then again via `bits/types/struct_timeval.h` which is included through
> > `linux/input.h > sys/time.h -> bits/types/struct_timeval.h`
>
> This is another header-coordination issue between the kernel and libc.
>
> In this case it's linux/time.h vs. sys/time.h.
>
> "Synchronizing Headers"
> https://sourceware.org/glibc/wiki/Synchronizing_Headers
> - Just added your case.
>
> It's not immediate clear to me if the UAPI header is clean enough to
> use directly in glibc or not, and that's often the simplest way to fix
> things.
>
> When you can't just use the kernel header definitions then you have
> to work through the conflict and decide if you want to allow both headers
> to be potentially included and in which orders to support it.
>
> Why do you need both headers included?
>
> --
> Cheers,
> Carlos.
>


-- 
PGP: 5607C93B5F86650C
