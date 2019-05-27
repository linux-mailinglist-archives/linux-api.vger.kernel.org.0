Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AABC2AF47
	for <lists+linux-api@lfdr.de>; Mon, 27 May 2019 09:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725973AbfE0HQP (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 27 May 2019 03:16:15 -0400
Received: from mga09.intel.com ([134.134.136.24]:16335 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbfE0HQP (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Mon, 27 May 2019 03:16:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 May 2019 00:16:13 -0700
X-ExtLoop1: 1
Received: from cli6-desk1.ccr.corp.intel.com (HELO [10.239.161.118]) ([10.239.161.118])
  by fmsmga001.fm.intel.com with ESMTP; 27 May 2019 00:16:11 -0700
Subject: Re: [PATCH v18 1/3] proc: add /proc/<pid>/arch_status
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     tglx@linutronix.de, mingo@redhat.com, peterz@infradead.org,
        hpa@zytor.com, ak@linux.intel.com, tim.c.chen@linux.intel.com,
        dave.hansen@intel.com, arjan@linux.intel.com, adobriyan@gmail.com,
        aubrey.li@intel.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Andy Lutomirski <luto@kernel.org>
References: <20190425143219.102258-1-aubrey.li@linux.intel.com>
 <20190523201822.cc554d68ec567164bec781e1@linux-foundation.org>
From:   "Li, Aubrey" <aubrey.li@linux.intel.com>
Message-ID: <d9c9e104-8062-961a-ede7-60d0590f942a@linux.intel.com>
Date:   Mon, 27 May 2019 15:16:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20190523201822.cc554d68ec567164bec781e1@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 2019/5/24 11:18, Andrew Morton wrote:
> On Thu, 25 Apr 2019 22:32:17 +0800 Aubrey Li <aubrey.li@linux.intel.com> wrote:
> 
>> The architecture specific information of the running processes
>> could be useful to the userland. Add /proc/<pid>/arch_status
>> interface support to examine process architecture specific
>> information externally.
> 
> I'll give this an
> 
> Acked-by: Andrew Morton <akpm@linux-foundation.org>

Thanks!

> 
> from a procfs POV and shall let the x86 maintainers worry about it.
> 
> I must say I'm a bit surprised that we don't already provide some form
> of per-process CPU-specific info anywhere in procfs.  Something to
> piggy-back this onto.  But I can't find such a thing.
> 
> I assume we've already discussed why this is a new procfs file rather
> than merely a new line in /proc/<pid>/status.  If so, please add the
> reasoning to the changelog.  If not, please discuss now ;)
>

Andy and Thomas may want to give more comments. The discussion was that
we don't want /proc/PID/status to be different on different architectures.
It would be better to separate the arch staff into its own file /proc/PID/
arch_status and make sure that everything in it is namespaced.

Thanks,
-Aubrey
