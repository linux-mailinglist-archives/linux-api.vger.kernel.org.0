Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B44D236069
	for <lists+linux-api@lfdr.de>; Wed,  5 Jun 2019 17:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfFEPj6 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 Jun 2019 11:39:58 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:44406 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728200AbfFEPj6 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 5 Jun 2019 11:39:58 -0400
Received: by mail-qk1-f195.google.com with SMTP id w187so5392020qkb.11;
        Wed, 05 Jun 2019 08:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XkK3it9qwdZSq91s1rnyVYmUTgpHaE4AnNYryBYUdwM=;
        b=Q3+HdRskeYHlYSkfrRZo6GdsYTy2c2e4x6g+bYwAUNzv6xgOoTQcCOPehF6viNil48
         4IHiGOzALoqsk2Eaup9OOZ6HgMaVVqWI7u+vDZVURC3XS45f/4kLDNsUUUDibEzn4Wrb
         uHDDDUsKHlORHU1T3qo/oUTHKDd++NZQl6n9iMyxhMmVIywxkHZ1rLMcynDbpqwZOyVB
         Woyp8aClZcu+uN7X1uwHy3rq+YElWGDSq6VbedDRMSpXO1kVgMlhIm0Dw/9mdk2tAjTh
         MuGEwDQaCjtq9SNt5evD8WWL/i9bs5dp67nZI2pkruEz2RSZHiSJEf0jGRXkPUDJfEjm
         8E4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=XkK3it9qwdZSq91s1rnyVYmUTgpHaE4AnNYryBYUdwM=;
        b=gn3wPSdtzytMJsHoGO/TbS6QNwYuq+sUnVC8Rop19JgsZxKW4FJK9QftR+pK6eLeDq
         aDk/6dltiMcTmp9oljW5Mgx9gMith+lKqWArEdlawKaKM9FE2514ZcX3aJGmUOwNqcaH
         S5m3mTrzZa0i2o/xlRpbuBL3dEKXGTV6MQQ50m7tNBlEqcNDdkLsjTtFtPSVSilxWf7H
         qehyPV4f34JvPq3DCtAqjGmfWqsNJFHbNYAu4jPquhkWWu+7bQhCjFfb/1j1LBLS3DYE
         FOBrwDPPTJX07wznV7bmOD26G9cQ/DKTwj1PNacBBIHYlmj2r06juQQaicS2I+ab0bm3
         HjsA==
X-Gm-Message-State: APjAAAXvKXitnsrB/63cne+O1v6sCfK2iEh2+eeMiBDbGa1GtGTnvj2j
        w2CZ7xEZcjiMLBWjP1DDr64=
X-Google-Smtp-Source: APXvYqyhu0d8EGS06R2iyU5QKh0lTB3eo3EDTgwoUoiBmSFffglAxu+Rf169kev/+EK63ivSevRatA==
X-Received: by 2002:a37:a413:: with SMTP id n19mr32240823qke.98.1559749197309;
        Wed, 05 Jun 2019 08:39:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:c027])
        by smtp.gmail.com with ESMTPSA id c5sm9544509qtj.27.2019.06.05.08.39.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 08:39:56 -0700 (PDT)
Date:   Wed, 5 Jun 2019 08:39:55 -0700
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
Message-ID: <20190605153955.GP374014@devbig004.ftw2.facebook.com>
References: <20190515094459.10317-1-patrick.bellasi@arm.com>
 <20190515094459.10317-13-patrick.bellasi@arm.com>
 <20190531153545.GE374014@devbig004.ftw2.facebook.com>
 <20190603122725.GB19426@darkstar>
 <20190605140324.GL374014@devbig004.ftw2.facebook.com>
 <20190605143805.olk2ta5p2jnd4mjt@e110439-lin>
 <20190605144450.GN374014@devbig004.ftw2.facebook.com>
 <20190605153742.lusoiodrzxmpsrvd@e110439-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190605153742.lusoiodrzxmpsrvd@e110439-lin>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello, Patrick.

On Wed, Jun 05, 2019 at 04:37:43PM +0100, Patrick Bellasi wrote:
> > Everything sounds good to me.  Please note that cgroup interface files
> > actually use literal "max" for limit/protection max settings so that 0
> > and "max" mean the same things for all limit/protection knobs.
> 
> Lemme see if I've got it right, do you mean that we can:
> 
>  1) write the _string_ "max" into a cgroup attribute to:
> 
>     - set    0 for util_max, since it's a protection
>     - set 1024 for util_min, since it's a limit
>
>  2) write the _string_ "0" into a cgroup attribute to:
> 
>     - set 1024 for util_max, since it's a protection
>     - set    0 for util_min, since it's a limit
> 
> Is that correct or it's just me totally confused?

Heh, sorry about not being clearer.  "max" just means numerically
highest possible config for the config knob, so in your case, "max"
would always map to 1024.

Thanks.

-- 
tejun
