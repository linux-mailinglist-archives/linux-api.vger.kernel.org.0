Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 31ECC266CF
	for <lists+linux-api@lfdr.de>; Wed, 22 May 2019 17:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729758AbfEVPW4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 22 May 2019 11:22:56 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34022 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbfEVPW4 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 22 May 2019 11:22:56 -0400
Received: by mail-ed1-f68.google.com with SMTP id p27so4401802eda.1
        for <linux-api@vger.kernel.org>; Wed, 22 May 2019 08:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KgX/KrN1VzCWggUBQFeZMr9AktFTs8VZSbXFmnxyzvo=;
        b=GcX1w0fwJX3vDt7d78Vssz4hVA60VJ9U4c3rX8AHTSYZwQLeaXQVkinzSCIBDoZzTB
         rwjteMFRYCWTKo/ab71WxSj9adzyPMMkHiWBUYrwq1wlH5l9u1kkM9wUy2A5pDlg1ipU
         0NWe6dzLDpANP2IfKV2nDoRXiS/TfgK80rLRXC6Gg0WnwSp1HUw2TSiQmdBonr6HeVLi
         os009EzfGhQ0bhl4JAKB1Xh8I3kM+RJ6Zf4ycKBTBPmV2Vzzswaubzy6/tbn6IJqsM1U
         euI9QfMDbGy1rtN7YsZ+hzN9VvjWux2wM/nms0RxP+3k3fmvTRIuX/Bzv++iBVdECCOG
         7PsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KgX/KrN1VzCWggUBQFeZMr9AktFTs8VZSbXFmnxyzvo=;
        b=dQcc+nqlghvBxENaa2xAe/RwAwNsLtAzJIF5CIGhMOZDxRAn8SfNla/oUaRW8hIp6I
         WK9FR02CHNJ7lcnfY63QEu9mgd1nWgXHGoF75vOxJUdpKLuWw7N4QYbH13EQhpZsvlNG
         TwLK5wGsTVxtWm7A+cSrC1A4PNVSh4w5WUVyJCtVG+ScRnSGb4q/um0w/At8IVPLDCzP
         h2Ahv/uvmVgOzge+v3ZKr8gKjBrdLLk/guYYSlpafBspEiptecTd8Ptwpac2ZOtKm9in
         zRP1SPEvPPPziKJTp+RLQ5IPf3vMJziGPkK03Y+OOE1dx77LGmjAW9AsQ9AzQzvRr08H
         ydmg==
X-Gm-Message-State: APjAAAUq+7HlWr0O4m7R3SOQsOKWwwbYko6j3L2p8DiaYfcTrSuIg9Dy
        DB5+ldlgrc+xsJZNPuBYhMEKdw==
X-Google-Smtp-Source: APXvYqzHZikuU8IDFA19PCIsr47Prlil2YLLyeJWuJV/knew+rRRWt8W5HBqMojWnsIXz6OdXkkrWw==
X-Received: by 2002:a05:6402:1256:: with SMTP id l22mr61992618edw.22.1558538574434;
        Wed, 22 May 2019 08:22:54 -0700 (PDT)
Received: from box.localdomain (mm-192-235-121-178.mgts.dynamic.pppoe.byfly.by. [178.121.235.192])
        by smtp.gmail.com with ESMTPSA id n8sm3245262ejk.45.2019.05.22.08.22.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 08:22:53 -0700 (PDT)
Received: by box.localdomain (Postfix, from userid 1000)
        id 2576A103900; Wed, 22 May 2019 18:22:54 +0300 (+03)
Date:   Wed, 22 May 2019 18:22:54 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Kirill Tkhai <ktkhai@virtuozzo.com>
Cc:     akpm@linux-foundation.org, dan.j.williams@intel.com,
        mhocko@suse.com, keith.busch@intel.com,
        kirill.shutemov@linux.intel.com, alexander.h.duyck@linux.intel.com,
        ira.weiny@intel.com, andreyknvl@google.com, arunks@codeaurora.org,
        vbabka@suse.cz, cl@linux.com, riel@surriel.com,
        keescook@chromium.org, hannes@cmpxchg.org, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, shakeelb@google.com, guro@fb.com,
        aarcange@redhat.com, hughd@google.com, jglisse@redhat.com,
        mgorman@techsingularity.net, daniel.m.jordan@oracle.com,
        jannh@google.com, kilobyte@angband.pl, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 0/7] mm: process_vm_mmap() -- syscall for duplication
 a process mapping
Message-ID: <20190522152254.5cyxhjizuwuojlix@box>
References: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <155836064844.2441.10911127801797083064.stgit@localhost.localdomain>
User-Agent: NeoMutt/20180716
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, May 20, 2019 at 05:00:01PM +0300, Kirill Tkhai wrote:
> This patchset adds a new syscall, which makes possible
> to clone a VMA from a process to current process.
> The syscall supplements the functionality provided
> by process_vm_writev() and process_vm_readv() syscalls,
> and it may be useful in many situation.

Kirill, could you explain how the change affects rmap and how it is safe.

My concern is that the patchset allows to map the same page multiple times
within one process or even map page allocated by child to the parrent.

It was not allowed before.

In the best case it makes reasoning about rmap substantially more difficult.

But I'm worry it will introduce hard-to-debug bugs, like described in
https://lwn.net/Articles/383162/.

Note, that is some cases we care about rmap walk order (see for instance
mremap() case). I'm not convinced that the feature will not break
something in the area.

-- 
 Kirill A. Shutemov
