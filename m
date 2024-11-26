Return-Path: <linux-api+bounces-2788-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0569D90FC
	for <lists+linux-api@lfdr.de>; Tue, 26 Nov 2024 05:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93EC6168F7F
	for <lists+linux-api@lfdr.de>; Tue, 26 Nov 2024 04:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A73558222;
	Tue, 26 Nov 2024 04:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="rsBniZ8e"
X-Original-To: linux-api@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E1C3AC2B;
	Tue, 26 Nov 2024 04:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732594721; cv=none; b=rxUIBb37ZJciLMhF4h3IYjBQd7OwU4B+Ws2VesWQQ6eGp9GyQ6Yf+jTcRF7+IWePyk+3LWSCJjNfhyydabQxgFU08b97w27XlVNzHDvlj28sg7lluCcKx3on/nnpWK/xrza7jiW/k7q/8iJ5Uz0v8LrFTyPV7aI1gukbGHkrrlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732594721; c=relaxed/simple;
	bh=hgMLWw9D3PRfqpY/YSPRvy82YrAxoVzWlzxwJZi1OFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZpkItOFhz269UQsZWaopNfZbfuQL5xUkzsP8s7vRbo9mYTgQY+h2Ym5Ml6pFKVlEpjp4yeiVEKtaWNkEHVaaGGNK5RjfAKCvTVCvskXDPTIqdAujl+S4i9i16bhs5WzCkQak6bB2WSBLOoIoAqYezd0+B55bqqUvjfpTOqhqzsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=rsBniZ8e; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1732594711; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=KmDp0QCJrg41HTLms2JcwouXuGR0t74fGSXqjbEMyR8=;
	b=rsBniZ8eIn0CtFQQGXaJZKdTrKCtagrFldOE2A8SqGQbWuQWUDj7UA16pnQgP53+CwvgJizudKa0iyTmKatfeMAcphnKEu3wKjrgpvR0+IH37wIHFn3AfsBeDfrhWaoc3zwMceDmCJjVXhj8fC23Os7owp3UKtmucCu0+B3CTWQ=
Received: from 30.221.146.228(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0WKGm6Sh_1732594391 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 26 Nov 2024 12:13:12 +0800
Message-ID: <83688329-1eeb-4811-b488-b8950d3dcb0f@linux.alibaba.com>
Date: Tue, 26 Nov 2024 12:13:11 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 12/12] net: homa: create Makefile and Kconfig
To: John Ousterhout <ouster@cs.stanford.edu>,
 kernel test robot <lkp@intel.com>
Cc: netdev@vger.kernel.org, linux-api@vger.kernel.org,
 oe-kbuild-all@lists.linux.dev
References: <20241111234006.5942-13-ouster@cs.stanford.edu>
 <202411132114.VB5yFmtR-lkp@intel.com>
 <CAGXJAmyeJ2HWxOZj8uY0_Cu47Yy_hAYfSRGmYpNfLGd2PR7Q-Q@mail.gmail.com>
Content-Language: en-US
From: "D. Wythe" <alibuda@linux.alibaba.com>
In-Reply-To: <CAGXJAmyeJ2HWxOZj8uY0_Cu47Yy_hAYfSRGmYpNfLGd2PR7Q-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/19/24 5:23 AM, John Ousterhout wrote:
> I believe I have fixed all of the kernel test robot issues reported
> under this subject line.
> 
> -John-
> 

Hi John,

I guess you might need pass type u64 rather type int as the first argument into do_div().
In fact, this is not a simple warning, as it may cause anomalies.

// int segs;
u64 segs;
do_div(segs, max_seg_data);

// int segs_per_gso
u64 segs_per_gso;
do_div(segs_per_gso, max_seg_data);

D. Wythe

> 
> On Wed, Nov 13, 2024 at 5:53 AM kernel test robot <lkp@intel.com> wrote:
>>
>> Hi John,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on net-next/main]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/net-homa-define-user-visible-API-for-Homa/20241112-074535
>> base:   net-next/main
>> patch link:    https://lore.kernel.org/r/20241111234006.5942-13-ouster%40cs.stanford.edu
>> patch subject: [PATCH net-next v2 12/12] net: homa: create Makefile and Kconfig
>> config: riscv-randconfig-r112-20241113 (https://download.01.org/0day-ci/archive/20241113/202411132114.VB5yFmtR-lkp@intel.com/config)
>> compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
>> reproduce: (https://download.01.org/0day-ci/archive/20241113/202411132114.VB5yFmtR-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202411132114.VB5yFmtR-lkp@intel.com/
>>
>> sparse warnings: (new ones prefixed by >>)
>>>> net/homa/homa_sock.c:201:31: sparse: sparse: cast removes address space '__rcu' of expression
>>     net/homa/homa_sock.c:248:17: sparse: sparse: context imbalance in 'homa_sock_shutdown' - different lock contexts for basic block
>>     net/homa/homa_sock.c:303:21: sparse: sparse: context imbalance in 'homa_sock_bind' - different lock contexts for basic block
>>
>> vim +/__rcu +201 net/homa/homa_sock.c
>>
>> 8ddf00265eb650 John Ousterhout 2024-11-11  183
>> 8ddf00265eb650 John Ousterhout 2024-11-11  184  /*
>> 8ddf00265eb650 John Ousterhout 2024-11-11  185   * homa_sock_unlink() - Unlinks a socket from its socktab and does
>> 8ddf00265eb650 John Ousterhout 2024-11-11  186   * related cleanups. Once this method returns, the socket will not be
>> 8ddf00265eb650 John Ousterhout 2024-11-11  187   * discoverable through the socktab.
>> 8ddf00265eb650 John Ousterhout 2024-11-11  188   */
>> 8ddf00265eb650 John Ousterhout 2024-11-11  189  void homa_sock_unlink(struct homa_sock *hsk)
>> 8ddf00265eb650 John Ousterhout 2024-11-11  190  {
>> 8ddf00265eb650 John Ousterhout 2024-11-11  191          struct homa_socktab *socktab = hsk->homa->port_map;
>> 8ddf00265eb650 John Ousterhout 2024-11-11  192          struct homa_socktab_scan *scan;
>> 8ddf00265eb650 John Ousterhout 2024-11-11  193
>> 8ddf00265eb650 John Ousterhout 2024-11-11  194          /* If any scans refer to this socket, advance them to refer to
>> 8ddf00265eb650 John Ousterhout 2024-11-11  195           * the next socket instead.
>> 8ddf00265eb650 John Ousterhout 2024-11-11  196           */
>> 8ddf00265eb650 John Ousterhout 2024-11-11  197          spin_lock_bh(&socktab->write_lock);
>> 8ddf00265eb650 John Ousterhout 2024-11-11  198          list_for_each_entry(scan, &socktab->active_scans, scan_links) {
>> 8ddf00265eb650 John Ousterhout 2024-11-11  199                  if (!scan->next || scan->next->sock != hsk)
>> 8ddf00265eb650 John Ousterhout 2024-11-11  200                          continue;
>> 8ddf00265eb650 John Ousterhout 2024-11-11 @201                  scan->next = (struct homa_socktab_links *)hlist_next_rcu(&scan
>> 8ddf00265eb650 John Ousterhout 2024-11-11  202                                  ->next->hash_links);
>> 8ddf00265eb650 John Ousterhout 2024-11-11  203          }
>> 8ddf00265eb650 John Ousterhout 2024-11-11  204          hlist_del_rcu(&hsk->socktab_links.hash_links);
>> 8ddf00265eb650 John Ousterhout 2024-11-11  205          spin_unlock_bh(&socktab->write_lock);
>> 8ddf00265eb650 John Ousterhout 2024-11-11  206  }
>> 8ddf00265eb650 John Ousterhout 2024-11-11  207
>>
>> --
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki

