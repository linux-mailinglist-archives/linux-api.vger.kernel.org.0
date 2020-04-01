Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E3C519A8D4
	for <lists+linux-api@lfdr.de>; Wed,  1 Apr 2020 11:47:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731396AbgDAJrO (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 1 Apr 2020 05:47:14 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33795 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726974AbgDAJrO (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 1 Apr 2020 05:47:14 -0400
Received: by mail-ed1-f65.google.com with SMTP id o1so10634225edv.1;
        Wed, 01 Apr 2020 02:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=UQs3qixojtRbcypEuUuylzgYjPF6gRozY5Y+r1d0h9g=;
        b=Mz7ny0A2xrf5HrbIzWZdz+IyB5rnbfYVsuBRr6tEDUq1/byxuApJ61ugMutPAiqi2+
         A+146fS1JtrG5CEtzPIOK5BEvVxDaXo+rBV4xjaLZFaBQ/MYb5US8BJAFizcOmWUDECW
         Lu5WQu1uzRyOvwfdNnhFVP486ApjfMeDd++nnYHA3GyAlBXGxJP1hkB4WU5nAxHqXt6B
         HVqQRFdiCd3dl9b5FmuqOG2zzZv94i9lyFtnCSkQ6rNj+NLRnciDGxzkacdfjx35ocDI
         T6Q+NkNdNhrJMVjjGTVF9pauuP24/MAfH4YeUS5wAw4Lb0eegb75ywHxGC/9R86PotEm
         IG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=UQs3qixojtRbcypEuUuylzgYjPF6gRozY5Y+r1d0h9g=;
        b=sJsuUk8Wxdrz7vBzO3WgM7VzUSIKrw+JjKUI8m560uZPI9aDOqIJ+WF9BFcGZXVVGc
         Ia8hXJFMPvmUnh0SCOAAmTEH4fNPNWJHkU3jnWM0QU9wtoqymbCo6iT7IL+nMEN4wED/
         y/+tBJLQWCR0vRCHLYdi82A11/mvbx3FSUzdqw21L07XM1Wjl13ziIfvQpgd7SRw+Ib8
         zdZBoH3gv4dJTuJmMNKOXW4GiaK2jD6mrbBopauiy8kcW4l1WLmAqtXb2f1lbVirhBtu
         9ng7xfCiTAnak8i/Ic43XOn11PPTwHL/NRjkCfcTv7sPzQ+tkUq4jCP41aTsaMHtcQ1A
         Q+7g==
X-Gm-Message-State: ANhLgQ3ZIC6kqpITlFydgfWsLpRzgEyXBNUOMVM2PVLhUcZLqa4hXg2W
        ctJn33e+JyjP4H9MrjjWzHQhBYg+E/bvFyZnb4U=
X-Google-Smtp-Source: ADFU+vtypiGoknsOhdw/9BUv4k6PiY+/jLtetmDtA9uJp2fT60u5pwV06zheWK2JEYH3PivlgzFRgVdSOSLScbEjDec=
X-Received: by 2002:a17:906:398:: with SMTP id b24mr17753109eja.243.1585734432378;
 Wed, 01 Apr 2020 02:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200213182336.6663-1-mchristi@redhat.com> <20200214125440.GA1839@dhcp22.suse.cz>
In-Reply-To: <20200214125440.GA1839@dhcp22.suse.cz>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Wed, 1 Apr 2020 11:47:01 +0200
Message-ID: <CAKgNAkhGxmbD6Owkg6JFRbT18jXOr7D8_6L62oSTmE6WNWSDZQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] prctl.2: doc PR_SET/GET_IO_FLUSHER
To:     Mike Christie <mchristi@redhat.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        Michal Hocko <mhocko@kernel.org>,
        Dave Chinner <david@fromorbit.com>, masato.suzuki@wdc.com,
        damien.lemoal@wdc.com, "Darrick J. Wong" <darrick.wong@oracle.com>,
        bvanassche@acm.org, linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Mike,

Do you have a refresh of this patch, in the light of the comments?

Thanks,

Michael

On Fri, 14 Feb 2020 at 13:54, Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 13-02-20 12:23:36, Mike Christie wrote:
> > This patch documents the PR_SET_IO_FLUSHER and PR_GET_IO_FLUSHER
> > prctl commands added to the linux kernel for 5.6 in commit:
> >
> > commit 8d19f1c8e1937baf74e1962aae9f90fa3aeab463
> > Author: Mike Christie <mchristi@redhat.com>
> > Date:   Mon Nov 11 18:19:00 2019 -0600
> >
> >     prctl: PR_{G,S}ET_IO_FLUSHER to support controlling memory reclaim
> >
> > Signed-off-by: Mike Christie <mchristi@redhat.com>
> > Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>
> > ---
> >
> > V3:
> > - Replace emulation device example.
> >
> > V2:
> > - My initial patch for this was very bad. This version is almost 100%
> > taken word for word from Dave Chinner's review comments.
> >
> > Signed-off-by: Mike Christie <mchristi@redhat.com>
> > ---
> >  man2/prctl.2 | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/man2/prctl.2 b/man2/prctl.2
> > index 720ec04e4..58d77bf2e 100644
> > --- a/man2/prctl.2
> > +++ b/man2/prctl.2
> > @@ -1381,6 +1381,30 @@ system call on Tru64).
> >  for information on versions and architectures.)
> >  Return unaligned access control bits, in the location pointed to by
> >  .IR "(unsigned int\ *) arg2" .
> > +.TP
> > +.B PR_SET_IO_FLUSHER (Since Linux 5.6)
> > +An IO_FLUSHER is a user process that the kernel uses to issue IO
> > +that cleans dirty page cache data and/or filesystem metadata. The
> > +kernel may need to clean this memory when under memory pressure in
> > +order to free it. This means there is potential for a memory reclaim
> > +recursion deadlock if the user process attempts to allocate memory
> > +and the kernel then blocks waiting for it to clean memory before it
> > +can make reclaim progress.
> > +
> > +The kernel avoids these recursion problems internally via a special
> > +process state that prevents recursive reclaim from issuing new IO.
>
> I would refrain from describing the internal implementation. The
> important part is that this flag tells the kernel that IO_FLUSHER
> process gets a special treatment to workaround the deadlock.
>
> So anytime a process is involved in the IO path and the kernel cannot
> make a forward progress without it then the flag should be set.
>
> --
> Michal Hocko
> SUSE Labs



-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
