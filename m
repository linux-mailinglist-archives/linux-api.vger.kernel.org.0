Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC212E129
	for <lists+linux-api@lfdr.de>; Wed, 29 May 2019 17:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfE2Pec (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 May 2019 11:34:32 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40397 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726323AbfE2Pec (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 May 2019 11:34:32 -0400
Received: by mail-pg1-f194.google.com with SMTP id d30so112721pgm.7
        for <linux-api@vger.kernel.org>; Wed, 29 May 2019 08:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QBTLnNOV7gK8Yksv7/ZayOzF1A/1p3r3qfTWQfsr+5k=;
        b=qPW3ofQ+wrfRG8qTvQ96ZGHSSch5H/W2ns+8WOCWmmGhii04PuKOPIFYj5Qzmezyrn
         XJylyTsK2Tr2TK/sawOqiMtam5VtSXWuPFXfFao86OwuyTL3pDo7LpJzXS9M6biwfUD8
         kMjSawwtTyHDM1KcUcq+i6aOaNRJs0GWSqjUm9LNY5k9+Epka2VjJBVnBvR6QSUeV5vs
         7e2WChPI0sOT3pRj16QXUNZKZKBw3vjTrviS+bfjuq3DJd2uOS6kjLlbmNTbnOuD+aZy
         fz+wyvVgHEtIFUPFMBc3NV9Lf5JFtJWrohfYsoC/I0uwHiWOeaTBy7Cz7bDA1B/dyud9
         R2tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QBTLnNOV7gK8Yksv7/ZayOzF1A/1p3r3qfTWQfsr+5k=;
        b=q3l1/7sFiDakkR18Jt/oagwsf4H9vJfpQR+iVZgRR0jIDQuEDztX50d8mtzTl31A/Z
         1yOZP5ZDLRUKvO2T5cCTu75LzmkduVnERMH4lSf8ezPbX+ftTlEB26jew5RZBtaABjwx
         4CZc6hEyhuai4JuHLdgjBYcZe5/DwKEUKt2QsETBaHbAdYw4hXU1l5UvGt6TcUZEDyZz
         iN1IpkPMmH8GZvC8scd40XMJOLZAqv3vpxTgEPDT6H3Ybrz4gwROHc7o5qEjzn4tCf3j
         jiZ2/0awnxmnHyD9G5lJs7EZOsu5/Vl5Vp4xNcUi6ULhe7Y1J6TEqc6hBawjFiNpb3+s
         otTw==
X-Gm-Message-State: APjAAAUgMEkjBMwk94cbi43zYMv8hIxrAhUqxJpJ71UDWeoxuMK1qBOV
        ujs/jk3D3O2HHrbc7VjYTeMIFw==
X-Google-Smtp-Source: APXvYqz9StBcZoB5Lg6+nM4qZaCfAQ8ekNwP4Ue16YfIsljxMfwjXEp4FnMnFD/1+Og2xj8d24Oitw==
X-Received: by 2002:a63:7d09:: with SMTP id y9mr119516427pgc.350.1559144071263;
        Wed, 29 May 2019 08:34:31 -0700 (PDT)
Received: from cisco ([2601:280:b:edbb:840:fa90:7243:7032])
        by smtp.gmail.com with ESMTPSA id f5sm19296566pfn.161.2019.05.29.08.34.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 08:34:30 -0700 (PDT)
Date:   Wed, 29 May 2019 09:34:27 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Richard Guy Briggs <rgb@redhat.com>,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        sgrubb@redhat.com, omosnace@redhat.com, dhowells@redhat.com,
        simo@redhat.com, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>, ebiederm@xmission.com,
        nhorman@tuxdriver.com
Subject: Re: [PATCH ghak90 V6 02/10] audit: add container id
Message-ID: <20190529153427.GB8959@cisco>
References: <cover.1554732921.git.rgb@redhat.com>
 <9edad39c40671fb53f28d76862304cc2647029c6.1554732921.git.rgb@redhat.com>
 <20190529145742.GA8959@cisco>
 <CAHC9VhR4fudQanvZGYWMvCf7k2CU3q7e7n1Pi7hzC3v_zpVEdw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhR4fudQanvZGYWMvCf7k2CU3q7e7n1Pi7hzC3v_zpVEdw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, May 29, 2019 at 11:29:05AM -0400, Paul Moore wrote:
> On Wed, May 29, 2019 at 10:57 AM Tycho Andersen <tycho@tycho.ws> wrote:
> >
> > On Mon, Apr 08, 2019 at 11:39:09PM -0400, Richard Guy Briggs wrote:
> > > It is not permitted to unset the audit container identifier.
> > > A child inherits its parent's audit container identifier.
> >
> > ...
> >
> > >  /**
> > > + * audit_set_contid - set current task's audit contid
> > > + * @contid: contid value
> > > + *
> > > + * Returns 0 on success, -EPERM on permission failure.
> > > + *
> > > + * Called (set) from fs/proc/base.c::proc_contid_write().
> > > + */
> > > +int audit_set_contid(struct task_struct *task, u64 contid)
> > > +{
> > > +     u64 oldcontid;
> > > +     int rc = 0;
> > > +     struct audit_buffer *ab;
> > > +     uid_t uid;
> > > +     struct tty_struct *tty;
> > > +     char comm[sizeof(current->comm)];
> > > +
> > > +     task_lock(task);
> > > +     /* Can't set if audit disabled */
> > > +     if (!task->audit) {
> > > +             task_unlock(task);
> > > +             return -ENOPROTOOPT;
> > > +     }
> > > +     oldcontid = audit_get_contid(task);
> > > +     read_lock(&tasklist_lock);
> > > +     /* Don't allow the audit containerid to be unset */
> > > +     if (!audit_contid_valid(contid))
> > > +             rc = -EINVAL;
> > > +     /* if we don't have caps, reject */
> > > +     else if (!capable(CAP_AUDIT_CONTROL))
> > > +             rc = -EPERM;
> > > +     /* if task has children or is not single-threaded, deny */
> > > +     else if (!list_empty(&task->children))
> > > +             rc = -EBUSY;
> > > +     else if (!(thread_group_leader(task) && thread_group_empty(task)))
> > > +             rc = -EALREADY;
> > > +     read_unlock(&tasklist_lock);
> > > +     if (!rc)
> > > +             task->audit->contid = contid;
> > > +     task_unlock(task);
> > > +
> > > +     if (!audit_enabled)
> > > +             return rc;
> >
> > ...but it is allowed to change it (assuming
> > capable(CAP_AUDIT_CONTROL), of course)? Seems like this might be more
> > immediately useful since we still live in the world of majority
> > privileged containers if we didn't allow changing it, in addition to
> > un-setting it.
> 
> The idea is that only container orchestrators should be able to
> set/modify the audit container ID, and since setting the audit
> container ID can have a significant effect on the records captured
> (and their routing to multiple daemons when we get there) modifying
> the audit container ID is akin to modifying the audit configuration
> which is why it is gated by CAP_AUDIT_CONTROL.  The current thinking
> is that you would only change the audit container ID from one
> set/inherited value to another if you were nesting containers, in
> which case the nested container orchestrator would need to be granted
> CAP_AUDIT_CONTROL (which everyone to date seems to agree is a workable
> compromise).

But then don't you want some kind of ns_capable() instead (probably
not the obvious one, though...)? With capable(), you can't really nest
using the audit-id and user namespaces together.

Tycho
