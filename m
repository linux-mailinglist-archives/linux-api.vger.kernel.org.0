Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50F0F19CACD
	for <lists+linux-api@lfdr.de>; Thu,  2 Apr 2020 22:12:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388242AbgDBUMj (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 2 Apr 2020 16:12:39 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37221 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729123AbgDBUMj (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 2 Apr 2020 16:12:39 -0400
Received: by mail-ed1-f68.google.com with SMTP id de14so6078612edb.4;
        Thu, 02 Apr 2020 13:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=T+mdDv2o4qw148SQ2RO/8yaxT59TE2MvJ+X7iPWLruI=;
        b=lOyEmfuMgu4nM2UlmIJ05f6ya3kVrmsClUpyXI8lhqdQZJoQcghsYH9A17QrubZoVo
         ouLpQrNQyewYo0Hgmstep4GZ9aydLdwjDmSIqltbhR4JRTl3+UXpSs+duJ9STlste8vv
         zv3sDv2NWzAGUCEDbEgPz4l1HISFyqbnslCd3jx4dOzG/1idMKNXu8n3QK+YY/4asnJp
         db4Kc0Fy8fhVKiKe7SPpbKxLJtBLZbbh3Dl4HO7Kh7FsArZsPVqTHVOVzT3rvq7IXhl4
         BLGaLNWHlQS4WsxIwLex+CPyJAjCo+CSCFiz0TIQWP2paRlDzO5iOYXM9QD3mhg4KvLs
         WsZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=T+mdDv2o4qw148SQ2RO/8yaxT59TE2MvJ+X7iPWLruI=;
        b=m0wbFPYs/yFsNbx1JlG1QcuuiC9WKwoLxitx1yLxlnDF68sLU41+/i5r5xEpSjTn+J
         YKNCEZ7LNNiaXwnt5fz9CSGezZknWTnrI9o+LExrg09ScFmliBbWavIJS5WRR1DB7+tb
         S9MpczZ2lPwHqduM/QWglgtx/N146xaCytAzmscI89kls7AKFd3cjrxQkIsDDdUOgGvf
         uESZsdyJWoMS0bwGRrSw9DKQIM2hxOdOuRFqRFrsu0E3caMaQ14pKo4db/tV3e3b3U+7
         JeZVSu6IZ7ENqBIgsiFkNkDUXVgWH0cPxGVcek6Ce0QdL/bioEE6CIeeFvHz3KnmkUX9
         pXnw==
X-Gm-Message-State: AGi0PubA1I9fsfkYHJp6qrb/fxoaUfKdh+EWmHs2lIc79EYPGWBwEugT
        Ou9k8i2bpmPO7G19lRWvY+S810s+S3twXN5+44k=
X-Google-Smtp-Source: APiQypI1Pq5fTtm+F/ez/Gz7Kt70/XYeCGI0XFO/HJeWNwMwGEe1+EeK4ncKNPaAwmGfU8BwlxR90c/G2x0kHnyrkE4=
X-Received: by 2002:a17:906:8042:: with SMTP id x2mr5033753ejw.157.1585858356918;
 Thu, 02 Apr 2020 13:12:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200402020850.7218-1-mchristi@redhat.com> <9eab1b92-6a44-616a-44b2-f1ee6475f6f0@acm.org>
 <c2451ffc-da39-9914-2d2e-e3a9a8356298@redhat.com>
In-Reply-To: <c2451ffc-da39-9914-2d2e-e3a9a8356298@redhat.com>
Reply-To: mtk.manpages@gmail.com
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Thu, 2 Apr 2020 22:12:25 +0200
Message-ID: <CAKgNAki_5SBbQJdjg1j0i5BvfUu7sXUiBbgBU8QJY+Av-Ok-pg@mail.gmail.com>
Subject: Re: [PATCH] prctl.2: doc PR_SET/GET_IO_FLUSHER - V4
To:     Mike Christie <mchristi@redhat.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Linux API <linux-api@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Michal Hocko <mhocko@suse.com>, masato.suzuki@wdc.com,
        damien.lemoal@wdc.com, "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, 2 Apr 2020 at 16:01, Michael Christie <mchristi@redhat.com> wrote:
>
> On 04/01/2020 10:46 PM, Bart Van Assche wrote:
> > On 2020-04-01 19:08, Mike Christie wrote:
> >> +.TP
> >> +.B PR_GET_IO_FLUSHER (Since Linux 5.6)
> >> +Return as the function result 1 if the caller is in the IO_FLUSHER state and
> >> +0 if not.
> >
> > Although I'm not at all a language expert, the word order at the start
> > of the above sentence seems a bit weird to me?
> >
>
> Do you mean the "Return as the function result" part or something else?
>
> That is how the other commands worded it. It looks like I messed up and
> dropped the (). This is how they did it:
>
> "Return (as the function result)"
>
> I will resend with that fix.
>
> If I misunderstood you I will fix that too.

I already fixed this piece. There are still the open questions in my
other mail though.


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
