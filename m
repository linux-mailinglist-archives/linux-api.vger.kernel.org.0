Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6011D35E94
	for <lists+linux-api@lfdr.de>; Wed,  5 Jun 2019 16:03:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfFEOD3 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 Jun 2019 10:03:29 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:42167 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727904AbfFEOD3 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 5 Jun 2019 10:03:29 -0400
Received: by mail-qk1-f195.google.com with SMTP id b18so5177115qkc.9;
        Wed, 05 Jun 2019 07:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=f6orNuflfpi/L3sTi5ZaDirO8JuaPSKQH84xtYNONWM=;
        b=RZdAAQPt6WLQXxLXFTqxAOZcDCcj51rKuFqL23agtoGAez6DbDQWDQjEf/3YKJ26R3
         +EQvV8tKubBKndgBS636qEdGdAitdIk0u3hkDLdlkARLgkOVfGZp6lzQAiX77ydTpy0K
         tDE34EuMv7Ngb0CAB8hmT56c2QS85np5eBO9wlEo/smQ0VzbD9D00Zgy3Gs82nWKU+V0
         nOaAiE3Vd8/CqhXVVKlr59UGzB9d7MP02RSLiO4G1HZ6tgWWkQorVfh+14KAk+c76/pL
         s23RcUv7wAuYqhd17VOcKlEX1fDZ86qQz6ZzsUwEMSp4m5XuiYbZg71do0uJHUdpisup
         Xo3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=f6orNuflfpi/L3sTi5ZaDirO8JuaPSKQH84xtYNONWM=;
        b=Z5wLmK0wJcT8vLwtzYfgUo8kqCN3zOlJ04RybbdOxSYvIhFfGTQpHMwNhZLQ61GPKd
         IzKzCXqFrXgLu2Rk4tCJ5v9g2R3jeyqEH1PVN3KAE2f2KLzmSVfv4YscDIG+5RVtCNcL
         gZV2/eUQT7vOas9Y58YA+UlPIkagAo5qXa7g/KJLV2/ATo+Apnee5SsUFGNQzUlHs6ox
         DfHQM1vC1VHZGkkRcqDW9dRsmHMGCd2E8baEOejX7uZt7uXbjYb2J9mfwO7y21TT7eQM
         BPdlYzcoPoaZwniUf8c+tDksGvwVOE/E2zsJnbImnXEmBQBOnp02clwD31Ct1nC0qJaJ
         sZ6A==
X-Gm-Message-State: APjAAAXHe/tevvd0trGuKBvTBYsouS7no7Kx2RaXHZIMKMV4U3OWQ87j
        XfPHMiLZQ+uTL9QWWqbG4Rw=
X-Google-Smtp-Source: APXvYqx8SZuzka43OAiOQCl9D4I/STrncg0SwXXrsQjvIksiCWGAhKNHCpEOvGfdIQxTImRs6VIS/w==
X-Received: by 2002:a37:6587:: with SMTP id z129mr1089235qkb.295.1559743407586;
        Wed, 05 Jun 2019 07:03:27 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c027])
        by smtp.gmail.com with ESMTPSA id 17sm12485812qtr.65.2019.06.05.07.03.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 07:03:25 -0700 (PDT)
Date:   Wed, 5 Jun 2019 07:03:24 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-api@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20190605140324.GL374014@devbig004.ftw2.facebook.com>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
 <20190515094459.10317-13-patrick.bellasi@arm.com>
 <20190531153545.GE374014@devbig004.ftw2.facebook.com>
 <20190603122725.GB19426@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603122725.GB19426@darkstar>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello,

On Mon, Jun 03, 2019 at 01:27:25PM +0100, Patrick Bellasi wrote:
> All the above, to me it means that:
>  - cgroups are always capped by system clamps
>  - cgroups can further restrict system clamps
> 
> Does that match with your view?

Yeah, as long as what's defined at system level clamps everything in
the system whether they're in cgroups or not, it's all good.

> > * Limits (high / max) default to max.  Protections (low / min) 0.  A
> >   new cgroup by default doesn't constrain itself further and doesn't
> >   have any protection.
> 
> Example 2
> ---------
> 
> Let say we have:
> 
>   /tg1:
>         util_min=200 (as a protection)
>         util_max=800 (as a limit)
> 
> the moment we create a subgroup /tg1/tg11, in v9 it is initialized
> with the same limits _and protections_ of its father:
> 
>   /tg1/tg11:
>         util_min=200 (protection inherited from /tg1)
>         util_max=800 (limit inherited from /tg1)
> 
> Do you mean that we should have instead:
> 
>   /tg1/tg11:
>         util_min=0   (no protection by default at creation time)
>         util_max=800 (limit inherited from /tg1)
> 
> 
> i.e. we need to reset the protection of a newly created subgroup?

The default value for limits should be max, protections 0.  Don't
inherit config values from the parent.  That gets confusing super fast
because when the parent config is set and each child is created plays
into the overall configuration.  Hierarchical confinements should
always be enforced and a new cgroup should always start afresh in
terms of its own configuration.

> > * A limit defines the upper ceiling for the subtree.  If an ancestor
> >   has a limit of X, none of its descendants can have more than X.
> 
> That's correct, however we distinguish between "requested" and
> "effective" values.

Sure, all property propagating controllers should.

> > Note that there's no way for an ancestor to enforce protection its
> > descendants.  It can only allow them to claim some.  This is
> > intentional as the other end of the spectrum is either descendants
> > losing the ability to further distribute protections as they see fit.
> 
> Ok, that means I need to update in v10 the initialization of subgroups
> min clamps to be none by default as discussed in the above Example 2,
> right?

Yeah and max to max.

Thanks.

-- 
tejun
