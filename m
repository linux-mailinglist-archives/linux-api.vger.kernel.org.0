Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 818E23604C
	for <lists+linux-api@lfdr.de>; Wed,  5 Jun 2019 17:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbfFEP17 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 Jun 2019 11:27:59 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40175 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728390AbfFEP17 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 5 Jun 2019 11:27:59 -0400
Received: by mail-qt1-f194.google.com with SMTP id a15so3928922qtn.7;
        Wed, 05 Jun 2019 08:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DoYP3SXq/F69tuFAtMw8bYjy0iDS2z1aQ6oaElaTXL8=;
        b=pEDdS/Gt9MDlY9k11wK/L3izJSlmNQGxdN8DnF2v/gdBy7xtXb8UJdX42bIYBBI5QB
         n9Rvr5rOrDrn95t6jDQVNX+JfdWUG6xp3BKnPO/rTE/dbe3Rv0wAn/83itq3kpa4EcBP
         bTiwnt/LzUYaJhSwJFtJmggS1qHOJNzW3aVWcRMtPpLRFfwufoBSk/8XPc4DXnqxMBGc
         4zzOq7uygtQ88uNtCZ9Wt+L+qFGKjI5oSOwnBpGUIuaRP3dgDaznJxn3tS97HjrFQxrG
         2wBAx5OaG2PFz1XAFeDHxdMc5aqKtBJIugmoFREvlnuULQVEZUEc/qw8p5z/7jjQ8MxC
         H2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DoYP3SXq/F69tuFAtMw8bYjy0iDS2z1aQ6oaElaTXL8=;
        b=emGzmP3oQxGesGWu132xIrSO/FX/OgV6RxXR0EHgBgodtJfG9P0rbjIqRKAtg18prt
         1JRGs/e5CrqQDkPtRh1VVueagjFkejgvznsThpEcEslYIzUUu+wxrm9rGHjRFZMxv3LM
         RWWIAOg7Bjgemjh1b4VMPs0rEQnPkgL2LFp44jlTpeMYNugIRodEYmS98MJF6WHoHkUl
         N/GuzQtz5U9lxgL1vHNq90pWPoESXOz1amU3MYYlvHYD56B0eVguTOl1cZq/2679HPct
         BZuQAY4qOWsHVnzYPT/ubSKRxjtHmMJCQneSuPWo+RE3UVJViPQQHyIJCzMSqCEiHq5G
         1ysg==
X-Gm-Message-State: APjAAAVaxq+XMMnWFXhUtZrbbugMQfDDKgRrVYW6jqaaVovwDbBv1n9M
        9eNgl49K/avirE8lVfGAi44=
X-Google-Smtp-Source: APXvYqxGSPbzamSX1tRyVLk9HFMCpuOKya9aHxwl9uQDtiW/Cl9yo+PicBLUpAo4n+Pj3Kry+APbrQ==
X-Received: by 2002:a0c:95b3:: with SMTP id s48mr17429642qvs.84.1559748477813;
        Wed, 05 Jun 2019 08:27:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c027])
        by smtp.gmail.com with ESMTPSA id t197sm6390498qke.2.2019.06.05.08.27.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 08:27:56 -0700 (PDT)
Date:   Wed, 5 Jun 2019 08:27:54 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Paul Turner <pjt@google.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Todd Kjos <tkjos@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Steve Muckle <smuckle@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: Re: [PATCH v9 12/16] sched/core: uclamp: Extend CPU's cgroup
 controller
Message-ID: <20190605152754.GO374014@devbig004.ftw2.facebook.com>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
 <20190515094459.10317-13-patrick.bellasi@arm.com>
 <20190531153545.GE374014@devbig004.ftw2.facebook.com>
 <20190603122929.GC19426@darkstar>
 <20190605140943.GM374014@devbig004.ftw2.facebook.com>
 <20190605150630.vh5pyfpd6y3mfcaa@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605150630.vh5pyfpd6y3mfcaa@e110439-lin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello, Patrick.

On Wed, Jun 05, 2019 at 04:06:30PM +0100, Patrick Bellasi wrote:
> The only additional point I can think about as a (slightly) stronger
> reason is that I guess we would like to have the same API for cgroups
> as well as for the task specific and the system wide settings.
> 
> The task specific values comes in via the sched_setattr() syscall:
> 
>    [PATCH v9 06/16] sched/core: uclamp: Extend sched_setattr() to support utilization clamping
>    https://lore.kernel.org/lkml/20190515094459.10317-7-patrick.bellasi@arm.com/
> 
> where we need to encode each clamp into a __u32 value.
> 
> System wide settings are expose similarly to these:
> 
>    grep '' /proc/sys/kernel/sched_*
> 
> where we have always integer numbers.
> 
> AFAIU your proposal will require to use a "scaled percentage" - e.g.
> 3844 for 38.44% which however it's still not quite the same as writing
> the string "38.44".
> 
> Not sure that's a strong enough argument, is it?

It definitely is an argument but the thing is that the units we use in
kernel API are all over the place anyway.  Even for something as
simple as sizes, we use bytes, 512 byte sectors, kilobytes and pages
all over the place.  Some for good reasons (as you mentioned above)
and others for historical / random ones.

So, I'm generally not too concerned about units differing between
cgroup interface and, say, syscall interface.  That ship has sailed a
long while ago and we have to deal with it everywhere anyway (in many
cases there isn't even a good unit to pick for compatibility because
the existing interfaces are already mixing units heavily).  As long as
the translation is trivial, it isn't a big issue.  Note that some
translations are not trivial.  For example, the sched nice value
mapping to weight has a separate unit matching knob for that reason.

> > We can go into the weeds with the semantics but how about us using
> > an alternative adjective "misleading" for the cpu.util.min/max names
> > to short-circuit that?
> 
> Not quite sure to get what you mean here. Are you pointing out that
> with clamps we don't strictly enforce a bandwidth but we just set a
> bias?

It's just that "util" is already used a lot and cpu.util.max reads
like it should cap cpu utilization (wallclock based) to 80% and it's
likely that it'd read seem way to many other folks too.  A more
distinctive name signals that it isn't something that obvious.

Thanks.

-- 
tejun
