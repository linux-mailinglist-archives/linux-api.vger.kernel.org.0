Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C4824E087
	for <lists+linux-api@lfdr.de>; Fri, 21 Aug 2020 21:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726243AbgHUTPb (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Fri, 21 Aug 2020 15:15:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgHUTPa (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Fri, 21 Aug 2020 15:15:30 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A702C061573
        for <linux-api@vger.kernel.org>; Fri, 21 Aug 2020 12:15:30 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id md23so2827799ejb.6
        for <linux-api@vger.kernel.org>; Fri, 21 Aug 2020 12:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=stghTlyBapHk994fTHtMltbLyT6mOlKKkTF189OusPI=;
        b=VjNgrUm1v0IeHxdlDQ0CId/MrrRIGLSykTfWUhOMXaa+5c5Ox+rc6HV8mzndpk8qoI
         SlGp4gLF/RYuF3jYmM6JzdEZr9lKuv/dRZJpQ49hCQera3Cqt6s7k4BMzuKfiw6av94V
         c3lTpfClSIitbjMiPV26ArwYhM+shudRipL4ICzbvO653DXL74k0SxSHx/feRfR4Pl8O
         j0jOObYxDCZRdzWKMUAk6qiiJ3Hlqywc3HU4FWqit5X2R+q8/4y+0sM3IXTDe4dgCF//
         P+cTeJjQHezWI7/lkyQHpUTmarsZIlpTt2DKdHsGv005oUUel7Wa6PZa4ECzjTvkcrpb
         dBkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=stghTlyBapHk994fTHtMltbLyT6mOlKKkTF189OusPI=;
        b=WO69IrAERiYtjul5Xp3d4FXMbT32SAJKXIyz0CuWcDes9dLC1M9Kjn9cm5gK3zwQNK
         UIk09HnCYMk5oBj09ajbNJPmeRNv82871AVxLnezQT4Fjv8KEVp+nHh6CComzLrZf1Nw
         2CTGzNKFR8+r9j3Xhhzjr10CZO6KSfFjovx9H7fFrC6uXkiT7TonYOnrZLvrYg9x7Pdm
         VX5TaH8X5/6JCn4aGaY7Kkk3ltqd7KXOjwcZZb7yVFQSa8nlJcgu8KQ96A2rlc03lICP
         +dGMQW2pGzZ1gClcFPCjc7lAT6wCyqzQLNoMDG2bGUYHLiRb5JdEz8hZ4zNT0gt3TvD+
         V36g==
X-Gm-Message-State: AOAM5331KQOtDtjqUtT9t/nqLR+Mvt1fZtEOh2rosPfPccAQ4It2cnss
        UCwLBDS3MbbjSZ6DErjxHi4akrxYdafsE3HquHSP
X-Google-Smtp-Source: ABdhPJyjrpQ5CVzgJ6gkhEM2fio8YtcBd5YLkjExur1qaET+X/RSJIK7uZHEgYYREA2rYWWgZrtfuZgNL32OaMUA+Aw=
X-Received: by 2002:a17:906:1911:: with SMTP id a17mr3986360eje.431.1598037328746;
 Fri, 21 Aug 2020 12:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1593198710.git.rgb@redhat.com> <6e2e10432e1400f747918eeb93bf45029de2aa6c.1593198710.git.rgb@redhat.com>
 <CAHC9VhSCm5eeBcyY8bBsnxr-hK4rkso9_NJHJec2OXLu4m5QTA@mail.gmail.com> <20200729194058.kcbsqjhzunjpipgm@madcap2.tricolour.ca>
In-Reply-To: <20200729194058.kcbsqjhzunjpipgm@madcap2.tricolour.ca>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 21 Aug 2020 15:15:17 -0400
Message-ID: <CAHC9VhRUwCKBjffA_XNSjUwvUn8e6zfmy8WD203dK7R2KD0__g@mail.gmail.com>
Subject: Re: [PATCH ghak90 V9 05/13] audit: log container info of syscalls
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, Ondrej Mosnacek <omosnace@redhat.com>,
        dhowells@redhat.com, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com, Dan Walsh <dwalsh@redhat.com>,
        mpatel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Jul 29, 2020 at 3:41 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2020-07-05 11:10, Paul Moore wrote:
> > On Sat, Jun 27, 2020 at 9:22 AM Richard Guy Briggs <rgb@redhat.com> wrote:

...

> > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > index f03d3eb0752c..9e79645e5c0e 100644
> > > --- a/kernel/auditsc.c
> > > +++ b/kernel/auditsc.c
> > > @@ -1458,6 +1466,7 @@ static void audit_log_exit(void)
> > >         struct audit_buffer *ab;
> > >         struct audit_aux_data *aux;
> > >         struct audit_names *n;
> > > +       struct audit_contobj *cont;
> > >
> > >         context->personality = current->personality;
> > >
> > > @@ -1541,7 +1550,7 @@ static void audit_log_exit(void)
> > >         for (aux = context->aux_pids; aux; aux = aux->next) {
> > >                 struct audit_aux_data_pids *axs = (void *)aux;
> > >
> > > -               for (i = 0; i < axs->pid_count; i++)
> > > +               for (i = 0; i < axs->pid_count; i++) {
> > >                         if (audit_log_pid_context(context, axs->target_pid[i],
> > >                                                   axs->target_auid[i],
> > >                                                   axs->target_uid[i],
> > > @@ -1549,14 +1558,20 @@ static void audit_log_exit(void)
> > >                                                   axs->target_sid[i],
> > >                                                   axs->target_comm[i]))
> > >                                 call_panic = 1;
> > > +                       audit_log_container_id(context, axs->target_cid[i]);
> > > +               }
> >
> > It might be nice to see an audit event example including the
> > ptrace/signal information.  I'm concerned there may be some confusion
> > about associating the different audit container IDs with the correct
> > information in the event.
>
> This is the subject of ghat81, which is a test for ptrace and signal
> records.
>
> This was the reason I had advocated for an op= field since there is a
> possibility of multiple contid records per event.

I think an "op=" field is the wrong way to link audit container ID to
a particular record.  It may be convenient, but I fear that it would
be overloading the field too much.

Like I said above, I think it would be good to see an audit event
example including the ptrace/signal information.  This way we can talk
about it on-list and hash out the various solutions if it proves to be
a problem.

> > > @@ -1575,6 +1590,14 @@ static void audit_log_exit(void)
> > >
> > >         audit_log_proctitle();
> > >
> > > +       rcu_read_lock();
> > > +       cont = _audit_contobj_get(current);
> > > +       rcu_read_unlock();
> > > +       audit_log_container_id(context, cont);
> > > +       rcu_read_lock();
> > > +       _audit_contobj_put(cont);
> > > +       rcu_read_unlock();
> >
> > Do we need to grab an additional reference for the audit container
> > object here?  We don't create any additional references here that
> > persist beyond the lifetime of this function, right?
>
> Why do we need another reference?  There's one for each pointer pointing
> to it and so far we have just one from this task.  Or are you thinking
> of the contid hash list, which is only added to when a task points to it
> and gets removed from that list when the last task stops pointing to it.
> Later that gets more complicated with network namespaces and nested
> container objects.  For now we just needed it while generating the
> record, then it gets freed.

I don't think we need to grab an additional reference here, that is
why I asked the question.  The code above grabs a reference for the
audit container ID object associated with the current task and then
drops it before returning; if the current task, and it's associated
audit container ID object, disappears in the middle of the function
we've got much bigger worries :)

-- 
paul moore
www.paul-moore.com
