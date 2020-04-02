Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED77119CBF0
	for <lists+linux-api@lfdr.de>; Thu,  2 Apr 2020 22:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389318AbgDBUtO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Apr 2020 16:49:14 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36234 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732218AbgDBUtN (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Apr 2020 16:49:13 -0400
Received: by mail-oi1-f194.google.com with SMTP id k18so4128202oib.3;
        Thu, 02 Apr 2020 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I0hB3B5z4e9IJBGa/Hwle9+Mvl7ORMmg2rSQv7wVFtQ=;
        b=X2yAdA8iDb+GsZiK8GPYQpSIBN57tmK1nBObB4HgYecm6hKIKqMVEsiLvjBQSIFrKP
         7NwrIGh9rHiAbR8rGplfxoAcUhA82pz0ha/GFY9GaS4AoW4U2OYovisV+XofOUXealGB
         f5sLxT44rjTg/mqAQ43h/qwelUhqKBilnNgwGH+EbumWUOYwmaey1g9x7WvC7PQgKnO1
         kkyDdqHfdWWlns5kXjCcsxeSYJK/Fe5d48c1sZ3qi2Sp5E+1w2EZQwFjAekT1o1AYvAP
         pypsVo0rl6TP9JH+UHOMezKFlisRFrACO6wpPnkLMEpeofGmUDTwmt+9yieQcAAoB2jX
         pVKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I0hB3B5z4e9IJBGa/Hwle9+Mvl7ORMmg2rSQv7wVFtQ=;
        b=smJAgDKJMKaYZjEo/Y/qh7ZtZdtrJEu1OTgcDiK82SerUkKxXbjxfoGEVRtC+A6dVm
         eELvvvAWRh72khtymOWZ77ORSZ7fVMHFqn+p1LpqxGnOhx9szmgf9wu70J1agnhpVrRo
         6IsjXK3rXxCBcdU8jRKGuDVQF9DZH3YzNZOyfZJNSa6P5uDTZTDUmA7dGe4OtGmyiV+N
         w0+M8GnukwXeRsRgCIQkPL/r7qjuGpvVvgkevpbG1+iQCqRWxSvFXGXLjxn7L0QbM8qS
         p8W2AAJX+NEcq6ivLbKRHdHogwajVCk/1bbdRzUgug1xe9tZYpsdMublmDU/1x0dl7yI
         qZpA==
X-Gm-Message-State: AGi0PuaUmreiIscebcRdZkxMy66odbYN+FFk5lk+Bn9asWX/re4AUN1h
        vNqNbgEm2fAvxfXq26ELFk24vlYwDEsj1lNc/a4H/G3vf/8=
X-Google-Smtp-Source: APiQypLwAFKEXP9vB/xsNl6BJhyauYUc59fglKTc6KWHN9TcNm2F7fLjyWTEWw0o168c6gJT2FyvDDNjc9IT662z658=
X-Received: by 2002:aca:3b85:: with SMTP id i127mr657159oia.123.1585860552683;
 Thu, 02 Apr 2020 13:49:12 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkiTYY3mrdsWypX22WCczVK9GDsOO-Vq58go_b2=719=FA@mail.gmail.com>
 <ce049b034919c4a09629c2e7bec574af133fb064.1585837173.git.e@nanocritical.com>
 <CA+zRj8XYLpa_gep+VxUfQuqeKu+=thMit-jNv1soC8Mh5H43Ug@mail.gmail.com> <CAKgNAkipcX47quv23SACeorSexO00nUAJR3QSTA3bFNMresE4Q@mail.gmail.com>
In-Reply-To: <CAKgNAkipcX47quv23SACeorSexO00nUAJR3QSTA3bFNMresE4Q@mail.gmail.com>
From:   Eric Rannaud <eric.rannaud@gmail.com>
Date:   Thu, 2 Apr 2020 13:49:00 -0700
Message-ID: <CA+zRj8XzqV19Z9KcyO+_V2Nkt4fgwK7QbP01GE5EL=g_xHf8Xw@mail.gmail.com>
Subject: Re: [PATCH 1/1] clock_getres.2: dynamic POSIX clock devices can
 return other errors
To:     mtk.manpages@gmail.com
Cc:     Eric Rannaud <e@nanocritical.com>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Apr 2, 2020 at 1:19 PM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
> > There is documentation in:
> > - include/linux/posix-clock.h
> > - Documentation/driver-api/ptp.rst (explicitly states that EOPNOTSUPP
> > should be returned)
>
> (Is this a reference to the tack that I tweaked your patch to change
> EOPNOTSUPP to ENOTSUP?)

Oh not at all, I hadn't noticed your patch. I just wrote that sentence
to point to ptp.rst as a spec of sorts for that particular behavior
addressed by this patch.

I never know which one to use of EOPNOTSUPP or ENOTSUP since they have
the same value (in userspace) but POSIX.1 says they shouldn't. I
suppose for man2 it makes sense to pick one, whereas man3p has to make
the distinction.

For what it's worth, man2/ has 29 mentions of EOPNOTSUPP (value of 95
on x86) and 8 mentions of ENOTSUP (with a value 524).

In the kernel sources, it's 6324 vs 1512. But note that in kernel
code, EOPNOTSUPP has a value of 95 (on x86 anyway, it is arch
dependent), whereas ENOTSUP is 524. Glibc is the one that defines
ENOTSUP to EOPNOTSUPP.

So if we had to pick one for man2/ (and man7), I'd argue for
EOPNOTSUPP, for consistency with kernel code, now that I look at it in
more details.


> > - include/uapi/linux/ptp_clock.h
>
> ... it's a bit of a stretch to call any of those documentation, since
> they don't really describe the concept of a dynamic POSIX clock
> device.
>
> >
> > (IEEE 1588 PTP is the canonical user of these dynamic clock devices)
> >
> > Would you want to refer to any of these from the man page?
>
> See above. I would be happy to add a 2 or 3 sentence note to the page
> that briefly describes the concept of a POSIX clock. Would you be able
> to come up with something?

I'll try, but I've never used them, so I'm not convinced I can capture
the concept clearly.

Thanks,
Eric
