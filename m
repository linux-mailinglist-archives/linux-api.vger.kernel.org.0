Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 987C135F81
	for <lists+linux-api@lfdr.de>; Wed,  5 Jun 2019 16:44:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfFEOoz (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 Jun 2019 10:44:55 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44807 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727960AbfFEOoz (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 5 Jun 2019 10:44:55 -0400
Received: by mail-qt1-f193.google.com with SMTP id x47so18193542qtk.11;
        Wed, 05 Jun 2019 07:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5+amuC/f1g13FqxbZK0H3rjZkiafibYvngvdoJHTeaY=;
        b=Xaqop4NdhGsU31i8w22hqZOGA5bCkTzg6R5/EC23RiUJCzN5dtF4iVkzqxmY+7J7nX
         AfCP9j3/4u4rffKpsh9eGXyVuhVeR2HrVAZRtK+P1ffC5kcpdY3epjr2QWP3NZjrkenF
         8W3aRGBFCMgBLy8KknjGQHlImKIdbrIFC8KleevyNJ6JsC2MlBLiwtlvnsN0CSzMZr+n
         XnEvGmv/FOXw5+56Ja1z6QhroJqSBdPwfOCZ7OYZwnFJSflOfHZgSfFHnITUufXKnTDG
         R7LviF6TFrc6hpxIXyzLX773qaqqUragn0HHbmEHPg5NaM3JF4cyFtWeET4bCo0kJxrL
         GGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=5+amuC/f1g13FqxbZK0H3rjZkiafibYvngvdoJHTeaY=;
        b=naMpvJgK1oNQ+aoogGJgWT698/YYuF+m6lC7fJW2eK25Mzn6UZDZVhrkuWUKVvk+RX
         e3rtlaPtV+WTiXBGXkAWobaRT3D3uvaGdyqTWWwEVlrvTeLPdRWsY43aaIJdu0O4mHth
         zKHUrEpadjX5Q+VMMXxbnM/YYZAhn/9KTy7gLX8xvMDnyjbPgAyfqQxSTAoaCgBqxaHN
         HsbQazDbkq7BLw6kQCfD82ydpmLlGQ6cw3fhfQW7OEySFyfGUOhXbfWI5r7EDEn7/afB
         qHOHijo7Amah+uSbIplUxIBACkcUnZjEDRxx5nJ0301SODDuWNRfHfhpb6OT5j92HTBU
         eUVA==
X-Gm-Message-State: APjAAAWBlGIAeS2VKtWLd3fI6Yggf73ZxJjGmwEF3jLSO8lwYHAH0+4o
        EJkXhdGf1wYlVB7211+8Slk=
X-Google-Smtp-Source: APXvYqyHClRti1uqD1HXPdrPMGuakIUjLA2LyMPf4+a8tjzEnJIhKWBZFVZfpe9h9fo08DyAFybxXQ==
X-Received: by 2002:a0c:be87:: with SMTP id n7mr14243540qvi.65.1559745893929;
        Wed, 05 Jun 2019 07:44:53 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c027])
        by smtp.gmail.com with ESMTPSA id n19sm9375766qkg.58.2019.06.05.07.44.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 07:44:52 -0700 (PDT)
Date:   Wed, 5 Jun 2019 07:44:50 -0700
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
Message-ID: <20190605144450.GN374014@devbig004.ftw2.facebook.com>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
 <20190515094459.10317-13-patrick.bellasi@arm.com>
 <20190531153545.GE374014@devbig004.ftw2.facebook.com>
 <20190603122725.GB19426@darkstar>
 <20190605140324.GL374014@devbig004.ftw2.facebook.com>
 <20190605143805.olk2ta5p2jnd4mjt@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605143805.olk2ta5p2jnd4mjt@e110439-lin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello,

On Wed, Jun 05, 2019 at 03:39:50PM +0100, Patrick Bellasi wrote:
> Which means we will enforce the effective values as:
> 
>    /tg1/tg11:
> 
>          util_min.effective=0
>             i.e. keep the child protection since smaller than parent
> 
>          util_max.effective=800
>             i.e. keep parent limit since stricter than child
>
> Please shout if I got it wrong, otherwise I'll update v10 to
> implement the above logic.

Everything sounds good to me.  Please note that cgroup interface files
actually use literal "max" for limit/protection max settings so that 0
and "max" mean the same things for all limit/protection knobs.

Thanks.

-- 
tejun
