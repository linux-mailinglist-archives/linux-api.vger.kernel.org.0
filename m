Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A248C34AE
	for <lists+linux-api@lfdr.de>; Tue,  1 Oct 2019 14:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732692AbfJAMq4 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 1 Oct 2019 08:46:56 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43306 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387974AbfJAMqt (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 1 Oct 2019 08:46:49 -0400
Received: by mail-qk1-f193.google.com with SMTP id h126so11007988qke.10
        for <linux-api@vger.kernel.org>; Tue, 01 Oct 2019 05:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yhYK707SJYezdTmtlm0H5DzhvYDEY+AheUSfJipRwQA=;
        b=Ip07l89zJ0jmeRNnjuMLfwUjUW/Co9PU7e0m/xjX5PRGmc7z0AHojhkZabJt8X2Bgg
         g+nON2pSO1jYd3vrOuUPki6rr1yQEu8hEHqD2uxKaL1mXqoQO+mmyIxyk/MqTG+kwh7j
         k8s6vQHeaqcK2Ex9HxDcxmXOxrevnS6yuu8GEXyqlYjEZ0NonLeaC1CRZJXuD0MLzbKz
         KMfG1EI87v8Lxz8Ezrm+M3DQJYYjEG8yK9ND3K1qjmeVssoYCQLFRhdCLXQgMe4P5XGr
         47iPcjETHnPBpfL8Sd3yLzPtHoVT0IEvJrxtCfa4Pu82gMneNTnjOQOCUx8TaPMdQriE
         9BWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yhYK707SJYezdTmtlm0H5DzhvYDEY+AheUSfJipRwQA=;
        b=nynpESVioKEvvRsOWjUMjXgLQkfPs2Uso0nsPNetx8q/w19O/f0nh9jWDGunvBxNj2
         fA+h2hbOAjffvzWj98ZdaD6k+dO38wJYEH/44CB+ElbpmUS8Yef7Ph7uZSt9YqHBqScE
         xXTC+iPiDkYxPJQCsKzO0kZ2bxcRZtsYzcZAZ3WmJbQ84zRuEq7TmaDnE2Dh2ZeoioAv
         E1uja5lh86GVEENct7To34r49HEa/hpfB34f9WnMSgSBJh6IL6RbUiNYKVSiPDJCA1Et
         XfzPbG/lffThweSHzLfBalWWEpG4dlXyBuVfnscRiT2uxP3EozgfrzpzdHipC8kbOxUY
         NnPA==
X-Gm-Message-State: APjAAAUKG6X46N6Zd/xkjg4FWKB3s6Jf3V0HrMaJyRbj5zCKvMhZz11c
        DkYfo1juOAiLtGMaQAZnJwEcCw==
X-Google-Smtp-Source: APXvYqxfvaAa5fGyRQyIYajobY2F3QEa4iZspmX+Xrdwm3QyJhHVVt0YDLkyzlFTQn8rAQfDdMC0qg==
X-Received: by 2002:a37:a9d1:: with SMTP id s200mr5660408qke.251.1569934008434;
        Tue, 01 Oct 2019 05:46:48 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id n65sm7669877qkb.19.2019.10.01.05.46.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Oct 2019 05:46:47 -0700 (PDT)
Message-ID: <1569934004.5576.249.camel@lca.pw>
Subject: Re: [PATCH -next] treewide: remove unused argument in lock_release()
From:   Qian Cai <cai@lca.pw>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     akpm@linux-foundation.org, mingo@redhat.com, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        sean@poorly.run, airlied@linux.ie, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, gregkh@linuxfoundation.org,
        jslaby@suse.com, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, intel-gfx@lists.freedesktop.org,
        tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
        tj@kernel.org, mark@fasheh.com, jlbec@evilplan.org,
        joseph.qi@linux.alibaba.com, ocfs2-devel@oss.oracle.com,
        davem@davemloft.net, st@kernel.org, daniel@iogearbox.net,
        netdev@vger.kernel.org, bpf@vger.kernel.org, duyuyang@gmail.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        hannes@cmpxchg.org, mhocko@kernel.org, vdavydov.dev@gmail.com,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        alexander.levin@microsoft.com
Date:   Tue, 01 Oct 2019 08:46:44 -0400
In-Reply-To: <20190930072938.GK4553@hirez.programming.kicks-ass.net>
References: <1568909380-32199-1-git-send-email-cai@lca.pw>
         <20190930072938.GK4553@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Mon, 2019-09-30 at 09:29 +0200, Peter Zijlstra wrote:
> On Thu, Sep 19, 2019 at 12:09:40PM -0400, Qian Cai wrote:
> > Since the commit b4adfe8e05f1 ("locking/lockdep: Remove unused argument
> > in __lock_release"), @nested is no longer used in lock_release(), so
> > remove it from all lock_release() calls and friends.
> 
> Right; I never did this cleanup for not wanting the churn, but as long
> as it applies I'll take it.

Not sure when you would like to merge this. As you know, the longer it is
pending, the more churn it could have. If you could give me rough timeline
(i.e., aim for v5.4-rc2 or v5.5), I'll double-check for breakage and rebase it
if necessary.
