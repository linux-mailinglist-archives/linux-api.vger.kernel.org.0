Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 606AE144DBB
	for <lists+linux-api@lfdr.de>; Wed, 22 Jan 2020 09:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgAVI25 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 22 Jan 2020 03:28:57 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40442 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgAVI25 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 22 Jan 2020 03:28:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id t14so6170311wmi.5;
        Wed, 22 Jan 2020 00:28:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OjyMDyxydu3xzK47l5IL4JFwN0Gu9GPTlFI5eNh0tK4=;
        b=TfVh0mErf4YFTX7d1lW86D2wEgClcnHKnMFC4DKeKi8h3HjiCGY33neJmUJEfAos7/
         984P+N/EPPeYA5Jy1yQkHWy5bOdpJwpOm66N9XmADAOTWmXcDGVVLWSAf8bLeEUsLaPa
         uA8oXjNMrDdFLt4WqSi2L0PU8f/I/N0UHKWUwvQkC97FwyVRhScuh3IA/ilNh2q2E8Pw
         zgnLa4IcXMiu9DI+i4kjYsSEyTobGAoa82Ak/IbHRSw9DxJnUGhrVZWAgOvRpGdkXLVG
         eypZP1Qg+hkAfZOzoZN31xsjPOvzcl7mQbMSZzvpsYnmro2lZRqG2og1xLZEsDruqmPK
         7H+A==
X-Gm-Message-State: APjAAAWmcVML4xKGgzWnc6cCQ2BDCvwoUwS81sKNaZJUoMaYzgJzoSf5
        iL6NggFbh2h9iG5Qdou7/4w=
X-Google-Smtp-Source: APXvYqyl9MEI/mLqEYXS87KMyO+cKj6FxWSn6kU7Om0uM+ETRt7A6T7GavirDfhHCLA256MnMRhzOA==
X-Received: by 2002:a1c:1d02:: with SMTP id d2mr1688797wmd.185.1579681735851;
        Wed, 22 Jan 2020 00:28:55 -0800 (PST)
Received: from localhost (ip-37-188-245-167.eurotel.cz. [37.188.245.167])
        by smtp.gmail.com with ESMTPSA id o16sm3219887wmc.18.2020.01.22.00.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 00:28:55 -0800 (PST)
Date:   Wed, 22 Jan 2020 09:28:53 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     sspatil@google.com, kirill@shutemov.name,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org,
        oleksandr@redhat.com, surenb@google.com, timmurray@google.com,
        dancol@google.com, sonnyrao@google.com, bgeffon@google.com,
        hannes@cmpxchg.org, shakeelb@google.com, joaodias@google.com,
        ktkhai@virtuozzo.com, christian.brauner@ubuntu.com,
        sjpark@amazon.de
Subject: Re: [PATCH v2 2/5] mm: introduce external memory hinting API
Message-ID: <20200122082853.GS29276@dhcp22.suse.cz>
References: <20200116235953.163318-1-minchan@kernel.org>
 <20200116235953.163318-3-minchan@kernel.org>
 <20200117115225.GV19428@dhcp22.suse.cz>
 <20200117155837.bowyjpndfiym6cgs@box>
 <20200117173239.GB140922@google.com>
 <20200117212653.7uftw3lk35oykkmb@box>
 <20200119161431.GA94410@google.com>
 <20200120075825.GH18451@dhcp22.suse.cz>
 <20200121183212.GF140922@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200121183212.GF140922@google.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue 21-01-20 10:32:12, Minchan Kim wrote:
> On Mon, Jan 20, 2020 at 08:58:25AM +0100, Michal Hocko wrote:
[...]
> > The interface really has to be robust to future potential usecases.
> 
> I do understand your concern but for me, it's chicken and egg problem.
> We usually do best effort to make something perfect as far as possible
> but we also don't do over-engineering without real usecase from the
> beginning.
> 
> I already told you how we could synchronize among processes and potential
> way to be extended Daniel suggested(That's why current API has extra field
> for the cookie) even though we don't need it right now.

If you can synchronize with the target task then you do not need a
remote interface. Just use ptrace and you are done with it.

> If you want to suggest the other way, please explain why your idea is
> better and why we need it at this moment.

I believe I have explained my concerns and why they matter. All you are
saying is that you do not care because your particular usecase doesn't
care. And that is a first signal of a future disaster when we end up
with a broken and unfixable interface we have to maintain for ever.

I will not go as far as to nack this but you should seriously think
about other potential usecases and how they would work and what we are
going to do when a first non-cooperative userspace memory management
usecase materializes.
-- 
Michal Hocko
SUSE Labs
