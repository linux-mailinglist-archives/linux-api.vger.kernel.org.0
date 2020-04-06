Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7B619F401
	for <lists+linux-api@lfdr.de>; Mon,  6 Apr 2020 13:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbgDFLBK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Apr 2020 07:01:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:40635 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726841AbgDFLBK (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Apr 2020 07:01:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id w26so18660318edu.7;
        Mon, 06 Apr 2020 04:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=o38w4VfVzK/UVrYWQ9Xw7qG3Bt0q29XHLjGmHW6bD10=;
        b=m6U0AGEJ2nUhh9qGt6pap5Kqfb6KtpJWZpsCLZpMm9bwhf/IQpYRN9zYGtH6rV4Z2i
         nkKygNlJt8VNGP8sfEEM4hxE1Whp3ITrsHuJQsLUp9WG5jzK2eq3/ex/Fv33wYKQFiD4
         IsRnizij+sCjJbyHdIH2SARQ4y0ZdPBin5D/XHFG/c1WXo7TmD0Am+/n6zwJ1JV+rbKq
         5BcolmIycnH+VfDOunJ3fCm2OmE+2ZgMjRxiyBRkk9aoZSLIbZLt9nMHEpaLvdL6Xan7
         B+k5tGL9hBhFigy/RNY/UUusKOcnMSGld9TcF2GUzBj5MsyTVeQHoWUSk5eQPVoPsAug
         mqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=o38w4VfVzK/UVrYWQ9Xw7qG3Bt0q29XHLjGmHW6bD10=;
        b=n+ERJXEaTC/TNGCcBN2tyL29DkU3mKA3GkRKAg43wpGgZ+TkMhpkIRz/aawUSiUAib
         bJlDQko3CWosJuyvsDyO1lWxWubg7Oo1tq7bH42W8adg1xBOt0jMgaEQM2dWb80s091k
         622yN49Ocu0TtnIugorMkuaFQmXusE0fp3K0cWBN22+DQ6YekvA9Hv52u+coyV128e+f
         l1CSyXsHugGHHCykAQGakO3MYa57sdnEXHjxCuQhDIorzpzD4whP44y5nKCjAt5WZj++
         XfR3ZtVI24oUfMpOid61d1XstJmsgCY445OYtUsJZmO8/GYkNkmNtUUGF8UR3kjO5ReR
         4ifA==
X-Gm-Message-State: AGi0Pub8fSpDBGekw6JXOtm5gk42/bma1OFAR3t175bpfffGQ2hvL1ki
        Mqg4vMRHe7YglcYZEornqQtrjsg78dII4FixNVpyJ8gR
X-Google-Smtp-Source: APiQypItkmQVlpobOM3yxTfBkbGXRgyWSxMhxrsPlM41ktkSkYVMO2QzdSXIGDm1/3PSFL4Tjw8CxkFpXzp6YEyLrWQ=
X-Received: by 2002:aa7:cd5b:: with SMTP id v27mr18527574edw.286.1586170867902;
 Mon, 06 Apr 2020 04:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200402020850.7218-1-mchristi@redhat.com> <111926f0-942c-66ea-4e43-9f90e7b43549@gmail.com>
 <5E88F713.3050204@redhat.com>
In-Reply-To: <5E88F713.3050204@redhat.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Mon, 6 Apr 2020 13:00:00 +0200
Message-ID: <CAKgNAkigtfzQRNC+DkvmsQaytykhcwGjHucPhsxKhmd+OUkn9Q@mail.gmail.com>
Subject: Re: [PATCH] prctl.2: doc PR_SET/GET_IO_FLUSHER - V4
To:     Mike Christie <mchristi@redhat.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@suse.com>, masato.suzuki@wdc.com,
        damien.lemoal@wdc.com, "Darrick J. Wong" <darrick.wong@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi Mike,

On Sat, 4 Apr 2020 at 23:07, Mike Christie <mchristi@redhat.com> wrote:
>
> On 04/02/2020 07:16 AM, Michael Kerrisk (man-pages) wrote:
> > Hello Mike,
> >
> > On 4/2/20 4:08 AM, Mike Christie wrote:
> >> This patch documents the PR_SET_IO_FLUSHER and PR_GET_IO_FLUSHER
> >> prctl commands added to the linux kernel for 5.6 in commit:
> >>
> >> commit 8d19f1c8e1937baf74e1962aae9f90fa3aeab463
> >> Author: Mike Christie <mchristi@redhat.com>
> >> Date:   Mon Nov 11 18:19:00 2019 -0600>
> >>     prctl: PR_{G,S}ET_IO_FLUSHER to support controlling memory reclaim
> >>
> >> Signed-off-by: Mike Christie <mchristi@redhat.com>
> >
> > I've applied this patch, but I have some questions:
>
> Hey,
>
> Thanks for fixing up the patch for me.

you're welcome.

> > (a) What happens to the IO_FLUSHER setting in the child of fork(2)?
>
> The child will inherit the setting.
>
> > (b) What happens to the IO_FLUSHER setting during an execve(2)?
> >     (Is it preserved, reset, something else?)
>
> It's preserved.

Thanks. I added this text:

              The  IO_FLUSHER  state is inherited by a child process cre=E2=
=80=90
              ated via fork(2) and is preserved across execve(2).

Cheers,

Michael


--=20
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
