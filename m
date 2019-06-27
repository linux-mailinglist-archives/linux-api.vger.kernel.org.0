Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6606D58973
	for <lists+linux-api@lfdr.de>; Thu, 27 Jun 2019 20:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbfF0SGF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 27 Jun 2019 14:06:05 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:44481 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfF0SGF (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 27 Jun 2019 14:06:05 -0400
Received: by mail-ed1-f66.google.com with SMTP id k8so7918855edr.11
        for <linux-api@vger.kernel.org>; Thu, 27 Jun 2019 11:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=GNTzyha5uolkaXE/AKF7PBU/m2fQYAR8jso3b3bQxho=;
        b=m6y4j+YlgNsr629H/6PD1n/d7eQF/bkBheIl52SPCTGjhkZInu9kwhWyV6xo8kNYKD
         yW9xvLn6tcc/UhZ1t9w/7oCSIK6Vc7cAeNF1ujw0cWYoJ9L/EQaeAzVlDBsh5qQ+HxLB
         cH8PNBx5HRUIS74qnr91FI0M1RH074hNCCfXwE6ggsWmq6s/U7RoOlHwvpFF7HgPvyyw
         mjUyDP0Ghj3HoGxJp9lxEM2ZpSP6k9xFp1U/VO4rny6J3/W+RU9TtSfWSvoedcg/FZM3
         kNrp0BPWz4YjtLT0DHh2S/BgmzEt18f4tLKDNfLy9n9rAu/D4lhFEBrdEyZkl6qjrCpG
         +NjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=GNTzyha5uolkaXE/AKF7PBU/m2fQYAR8jso3b3bQxho=;
        b=LWBF3c//4wx1OdDWAvz6pRPmMB7/sko/VzHFaedwTqqo1ychvpDeONwFdoHXP+ARe0
         bds3Qoq7MI1GfUydS5x3KO2KhXxJ3tLO+GUlSSR4RDxPhOOQzwqrMkbxqcJeg5pW1vc+
         rKdtZs7KkNC7cDpY7ixaOpBFHPC6iB4Tl76EyBYp4wy95gPQD90C5xqzFSHzNbVFzb9S
         hFOBiwkL/xmXk3u0ZoNRGPRRu9vSg2hsOaGZHON5NSf9WRQ1bE4ga2N94j0Hh9IOuZT2
         5TXZoZ9Yy91FLn6Mqop/9fT4gkNy91D0q1Vq9P8Pd1bByQMAR3vBrgtwLzDbtmmbBs1w
         kmvg==
X-Gm-Message-State: APjAAAWX4oSJR95d42ncPNTKiAzsJ6Bko2O/7DU5sIiiO9hEIjXXae3a
        hdZvAUO5q7sRbsoOBA1QsVKz9w==
X-Google-Smtp-Source: APXvYqzGenvzx0Y0XnRI9xMYTAF7M9wkR56sl8+MbNVoy/EGzYm6e5vo9AYG/tf+nQsmZ+uVL9oupw==
X-Received: by 2002:a50:ac46:: with SMTP id w6mr6202710edc.238.1561658763449;
        Thu, 27 Jun 2019 11:06:03 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id d36sm934170ede.23.2019.06.27.11.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 11:06:02 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id E28C7103747; Thu, 27 Jun 2019 21:06:01 +0300 (+03)
Date:   Thu, 27 Jun 2019 21:06:01 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-api@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tim Murray <timmurray@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Daniel Colascione <dancol@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Sonny Rao <sonnyrao@google.com>, oleksandr@redhat.com,
        hdanton@sina.com, lizeb@google.com,
        Dave Hansen <dave.hansen@intel.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH v3 0/5] Introduce MADV_COLD and MADV_PAGEOUT
Message-ID: <20190627180601.xcppuzia3gk57lq2@box>
References: <20190627115405.255259-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190627115405.255259-1-minchan@kernel.org>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Thu, Jun 27, 2019 at 08:54:00PM +0900, Minchan Kim wrote:
> - Problem
> 
> Naturally, cached apps were dominant consumers of memory on the system.
> However, they were not significant consumers of swap even though they are
> good candidate for swap. Under investigation, swapping out only begins
> once the low zone watermark is hit and kswapd wakes up, but the overall
> allocation rate in the system might trip lmkd thresholds and cause a cached
> process to be killed(we measured performance swapping out vs. zapping the
> memory by killing a process. Unsurprisingly, zapping is 10x times faster
> even though we use zram which is much faster than real storage) so kill
> from lmkd will often satisfy the high zone watermark, resulting in very
> few pages actually being moved to swap.

Maybe we should look if we do The Right Thing™ at system-wide level before
introducing new API? How changing swappiness affects your workloads? What
is swappiness value in your setup?

-- 
 Kirill A. Shutemov
