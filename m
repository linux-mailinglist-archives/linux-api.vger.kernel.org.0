Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17AB725C806
	for <lists+linux-api@lfdr.de>; Thu,  3 Sep 2020 19:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbgICR01 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 3 Sep 2020 13:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbgICR0X (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 3 Sep 2020 13:26:23 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B623AC061244;
        Thu,  3 Sep 2020 10:26:23 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k15so1874524pji.3;
        Thu, 03 Sep 2020 10:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mlukllwXOvEWBwyxT6IJZnJXvBsYB26IwXfjpSrBgXM=;
        b=HTCenVFaASPOOyrZ4MuSvt5EQz8zWSEllLs/FvI1XXSg5kvv6+Bfy+9RyaGOfKCUlT
         M2N1CGRU4EKEWXTpNDHMaioJyuVY2r0F06hCuFhb7m6Q7yeQpYbv8Re9zlzH0R1Nkyv1
         GZ/KqhXoJhgW9OkWC1479sBJDsYwX/AaHj3ElLQIxjpMW4fPMqBEqwlOXtF/PKWtPmCR
         J50WmGly6CxH1zk2qLeeFWMTSGTpzk/PaaX0AGSsm9A/MZyrlu/WoCRSKrS6qBYAsMme
         fN3L53GqDHqDURfeVggvctHVfNI386/EhhjVCxHfshKbf8brlz3qhdHOULrCRJ931s8K
         3xfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mlukllwXOvEWBwyxT6IJZnJXvBsYB26IwXfjpSrBgXM=;
        b=UV3x2r9vsmaAkbUoX0bSDq19rc1vO9kIE52oL3VhPAxX6Sy0A9ZodevEKe/x088bFg
         Wb3QTIrUIRKTpmvkD0ZTSScUfAwk8kCxIz21Pog6C4Fm4hEc/ra3aKB3i6nCfGZ1Kuvf
         9lEqApaxDz09g0cPTrPPYM6aw7DWGGH7JRg/Tb1USVIJo93N86RjOPiXdu8GYlkpa3L5
         CPDgIt7G3Nb0ASZJv86eASBtedqNVFZTxt35/iyow1J5kHTnbVQVCLVRWCrdWkCiysf/
         zTDPl4dzUgUyCanZGHDWELc6vCNowbCSafA6kLA0l5dgf/LoGRpCsq/Kqdm8cq9gyCjG
         X8GA==
X-Gm-Message-State: AOAM530DK/QMinv7OwVB7mFWveB/rlkQ/CcKj0WmcrO7cySD65th+70l
        fXJEBuvmGh4fyTJqJQ98bx7HX0FPTZs=
X-Google-Smtp-Source: ABdhPJzH6ua6oUgv3mANunm8XzcHBa3n2YthyvHZ4FbZ3oyARraK6utFFmoqIxB2J7WlM3nGx/eerw==
X-Received: by 2002:a17:90a:5298:: with SMTP id w24mr4009307pjh.221.1599153982408;
        Thu, 03 Sep 2020 10:26:22 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:7220:84ff:fe09:5e58])
        by smtp.gmail.com with ESMTPSA id d8sm3230786pgt.19.2020.09.03.10.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2020 10:26:21 -0700 (PDT)
Date:   Thu, 3 Sep 2020 10:26:18 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        David Rientjes <rientjes@google.com>,
        Arjun Roy <arjunroy@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christian Brauner <christian@brauner.io>,
        Daniel Colascione <dancol@google.com>,
        Jens Axboe <axboe@kernel.dk>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>, linux-man@vger.kernel.org
Subject: Re: [PATCH v9 3/3] mm/madvise: introduce process_madvise() syscall:
 an external memory hinting API
Message-ID: <20200903172618.GB1959033@google.com>
References: <20200901000633.1920247-1-minchan@kernel.org>
 <20200901000633.1920247-4-minchan@kernel.org>
 <87blippc7p.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87blippc7p.fsf@mid.deneb.enyo.de>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Tue, Sep 01, 2020 at 08:46:02PM +0200, Florian Weimer wrote:
> * Minchan Kim:
> 
> >       ssize_t process_madvise(int pidfd, const struct iovec *iovec,
> >                 unsigned long vlen, int advice, unsigned int flags);
> 
> size_t for vlen provides a clearer hint regarding the type of special
> treatment needed for ILP32 here (zero extension, not changing the type
> to long long).
> 

All existing system calls using iove in Linux uses unsigned long so
I want to be consistent with them unless process_madvise need something
speicial.
