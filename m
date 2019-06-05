Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E483F35EBD
	for <lists+linux-api@lfdr.de>; Wed,  5 Jun 2019 16:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbfFEOJr (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 Jun 2019 10:09:47 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42566 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726442AbfFEOJr (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 5 Jun 2019 10:09:47 -0400
Received: by mail-qt1-f196.google.com with SMTP id s15so18055070qtk.9;
        Wed, 05 Jun 2019 07:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=v2MDSX43JHH0KYjwpIjVIi4kIeO7/cbyv9lPzZyoCrE=;
        b=OVxjPMU8vSgMBWq01KiF8vrtW3d0wVXT2TRlMY7sfjlbCyidt/5GhQIrM9QaBbhXK8
         yBBwNSjvNWUGNy4aaGMYIscuEKbhFOGhorRKCaOUadE8F9K+Of8SlEKCVZg/KO1AKcYZ
         pLPhZTy74Pp0mgiNyxkil96aHglcrJc55A9kqhfsBvTdbMQicRUtIMxj9hr9Ak9mHXnR
         tiG08FPK+JMidIbMnzDzsl6O7SEkqTX6bdUvGjwXdZIbxnFPnXRb7M5s0M0bzfi/NbiR
         2k+FWmDk0/4S1ptJ/zsgSvGr3S6p5nPv0UCDziiS9ndZTLXlodNZ377uPGrp/Ax6rZd/
         O1Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=v2MDSX43JHH0KYjwpIjVIi4kIeO7/cbyv9lPzZyoCrE=;
        b=EVNu17Neay7DNF2aLQM5Am2NV9N2wtZW0EtGXJL9KR5GdhEQzx6CD7LbwvTzulG/1O
         A69c6jIzdRu20y59Fd8WfPDsrgtZY51GVYX1LgYrHty1sBLJ1LaqvX0ziIjs37z3FVHP
         ol9wiYzHvsoqCvjuiGUTaS95xfJJjGJxQ+xbdWOA3JxeJyDst38PHYgKbuShRW/YUdyj
         qJjwK/azgOqyZ23/5Cb5+DbTIXJ6//5ozg+ECVKATE2vc0BnisMvruYxHU1nF2kxbnK2
         84kyJS39glXXbGS+/Rta8U3lVVSna9TYbWLDhEe7WELO5MLIIOoLGgfwmQRaz4stlApe
         PEgQ==
X-Gm-Message-State: APjAAAUDra4OFNuJxbofADSPl8Od4crKEiXS+0q1LJpUz6y8T4sGZ07I
        YLn9t7HsIZztAHx6vDIuQNk=
X-Google-Smtp-Source: APXvYqyznVqtqIoUN6wPQaRIrn1PSPcfNmqktReX7Bd4iJaFk86Dqnry9/4HbTgpLOJFuFZf4qUokQ==
X-Received: by 2002:a0c:baa7:: with SMTP id x39mr14333646qvf.100.1559743785693;
        Wed, 05 Jun 2019 07:09:45 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c027])
        by smtp.gmail.com with ESMTPSA id d5sm9336669qtj.3.2019.06.05.07.09.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 07:09:44 -0700 (PDT)
Date:   Wed, 5 Jun 2019 07:09:43 -0700
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
Message-ID: <20190605140943.GM374014@devbig004.ftw2.facebook.com>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
 <20190515094459.10317-13-patrick.bellasi@arm.com>
 <20190531153545.GE374014@devbig004.ftw2.facebook.com>
 <20190603122929.GC19426@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603122929.GC19426@darkstar>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello,

On Mon, Jun 03, 2019 at 01:29:29PM +0100, Patrick Bellasi wrote:
> On 31-May 08:35, Tejun Heo wrote:
> > Hello, Patrick.
> > 
> > On Wed, May 15, 2019 at 10:44:55AM +0100, Patrick Bellasi wrote:
> 
> [...]
> 
> > For proportions (as opposed to weights), we use percentage rational
> > numbers - e.g. 38.44 for 38.44%.  I have parser and doc update commits
> > pending.  I'll put them on cgroup/for-5.3.
> 
> That's a point worth discussing with Peter, we already changed one
> time from percentages to 1024 scale.

cgroup tries to uss uniform units for its interface files as much as
possible even when that deviates from non-cgroup interface.  We can
bikeshed the pros and cons for that design choice for sure but I don't
think it makes sense to deviate from that at this point unless there
are really strong reasons to do so.

> Utilization clamps are expressed as percentages by definition,
> they are just expressed in a convenient 1024 scale which should not be
> alien to people using those knobs.
> 
> If we wanna use a "more specific" name like uclamp.{min,max} then we
> should probably also accept to use a "more specific" metric, don't we?

Heh, this actually made me chuckle.  It's an interesting bargaining
take but I don't think that same word being in two different places
makes them tradable entities.  We can go into the weeds with the
semantics but how about us using an alternative adjective "misleading"
for the cpu.util.min/max names to short-circuit that?

Thanks.

-- 
tejun
