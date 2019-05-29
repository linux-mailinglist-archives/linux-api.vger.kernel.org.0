Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 34CD22E058
	for <lists+linux-api@lfdr.de>; Wed, 29 May 2019 16:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbfE2O5s (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 29 May 2019 10:57:48 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32992 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbfE2O5r (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 29 May 2019 10:57:47 -0400
Received: by mail-pf1-f194.google.com with SMTP id z28so1822906pfk.0
        for <linux-api@vger.kernel.org>; Wed, 29 May 2019 07:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tycho-ws.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sIAmsJEpBYAFITCiVn5ontRF8mPnuiYWYs/RXhqJVik=;
        b=WX7P/J1WgZ/D9lrZgOu1anQ6YIHb47wFUL+vzOPy5wp7tMGaB3GMXODl41EgHc8fmy
         O7CyTYBnpED9Ui08UL7+gG+G4ETtS6EPVbUOEwzGM3Gv+sMqOt9+eBigGG2ZScn8Gn+B
         mafYiq2WG7VzWLDTbnjHuyxYslOU/8LCyAkITg+lJDaaG8rsFUNzAf06z5HPQAwDuMnZ
         DDJCih2aBYGHvXSVQn3uSHbkEXIZIcuTm6aXFc7EHyMOA7oZW2kJ3aA+EKTvV+f/8kzR
         kd5R5mNQMOwiYz89vs7++vyO0bxo90i9bXogfTrnumYixYFV7p9mNBFBfwtXMp1IzGFS
         rm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sIAmsJEpBYAFITCiVn5ontRF8mPnuiYWYs/RXhqJVik=;
        b=OAQFNJw91RsGwjC3CpNBRNngVFgs0oDfuCoZWCIkmv7FCGscpEiknNyp0m+4X5SWza
         uD8vv8HVsGxPMYSHp3TjmjF35qjqANxs+FzXIs1fbceGwxveiUXflgYgtgar4CNRX7u6
         axVxlx9QyXHfyuxQuwylS1CUSuP9NaGLeJRDu4ie0g6tyCrcvKx6TeVlU83xIeZCVRTH
         u5s5jff/9ikcH5auLg9Pf6W27kxOfvcWV6rBbUtXZH/MuJ16gYQ1/Fczsj3ie1mxfUoT
         2JdIaWnlXa+AOturViQ5gE2RHPYFTypF+vbSww4ASm5hPBMn0YN974eiUrOqDrmJf/vl
         HRng==
X-Gm-Message-State: APjAAAUN0sAfEJbbTG1UMXNqoKBEGHyT+jv0B8LeynK/VcTnv8FcV+dw
        q0IAfULKOEZDWFZZzfz+piLEsg==
X-Google-Smtp-Source: APXvYqxNaNP9e3ltFNMVhA0l1R837lO1f6xlta8mbDk8OLksP1OtAUD8KUF2OzYdBkOo9TcqAUPkQg==
X-Received: by 2002:a63:ff0c:: with SMTP id k12mr32442911pgi.32.1559141866858;
        Wed, 29 May 2019 07:57:46 -0700 (PDT)
Received: from cisco ([2601:280:b:edbb:840:fa90:7243:7032])
        by smtp.gmail.com with ESMTPSA id t11sm15682423pgp.1.2019.05.29.07.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 07:57:46 -0700 (PDT)
Date:   Wed, 29 May 2019 08:57:42 -0600
From:   Tycho Andersen <tycho@tycho.ws>
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, netfilter-devel@vger.kernel.org,
        Paul Moore <paul@paul-moore.com>, sgrubb@redhat.com,
        omosnace@redhat.com, dhowells@redhat.com, simo@redhat.com,
        eparis@parisplace.org, serge@hallyn.com, ebiederm@xmission.com,
        nhorman@tuxdriver.com
Subject: Re: [PATCH ghak90 V6 02/10] audit: add container id
Message-ID: <20190529145742.GA8959@cisco>
References: <cover.1554732921.git.rgb@redhat.com>
 <9edad39c40671fb53f28d76862304cc2647029c6.1554732921.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9edad39c40671fb53f28d76862304cc2647029c6.1554732921.git.rgb@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, Apr 08, 2019 at 11:39:09PM -0400, Richard Guy Briggs wrote:
> It is not permitted to unset the audit container identifier.
> A child inherits its parent's audit container identifier.

...

>  /**
> + * audit_set_contid - set current task's audit contid
> + * @contid: contid value
> + *
> + * Returns 0 on success, -EPERM on permission failure.
> + *
> + * Called (set) from fs/proc/base.c::proc_contid_write().
> + */
> +int audit_set_contid(struct task_struct *task, u64 contid)
> +{
> +	u64 oldcontid;
> +	int rc = 0;
> +	struct audit_buffer *ab;
> +	uid_t uid;
> +	struct tty_struct *tty;
> +	char comm[sizeof(current->comm)];
> +
> +	task_lock(task);
> +	/* Can't set if audit disabled */
> +	if (!task->audit) {
> +		task_unlock(task);
> +		return -ENOPROTOOPT;
> +	}
> +	oldcontid = audit_get_contid(task);
> +	read_lock(&tasklist_lock);
> +	/* Don't allow the audit containerid to be unset */
> +	if (!audit_contid_valid(contid))
> +		rc = -EINVAL;
> +	/* if we don't have caps, reject */
> +	else if (!capable(CAP_AUDIT_CONTROL))
> +		rc = -EPERM;
> +	/* if task has children or is not single-threaded, deny */
> +	else if (!list_empty(&task->children))
> +		rc = -EBUSY;
> +	else if (!(thread_group_leader(task) && thread_group_empty(task)))
> +		rc = -EALREADY;
> +	read_unlock(&tasklist_lock);
> +	if (!rc)
> +		task->audit->contid = contid;
> +	task_unlock(task);
> +
> +	if (!audit_enabled)
> +		return rc;

...but it is allowed to change it (assuming
capable(CAP_AUDIT_CONTROL), of course)? Seems like this might be more
immediately useful since we still live in the world of majority
privileged containers if we didn't allow changing it, in addition to
un-setting it.

Tycho
