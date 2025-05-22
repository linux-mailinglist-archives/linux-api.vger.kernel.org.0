Return-Path: <linux-api+bounces-3840-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B40AC05D7
	for <lists+linux-api@lfdr.de>; Thu, 22 May 2025 09:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81B913AD6AD
	for <lists+linux-api@lfdr.de>; Thu, 22 May 2025 07:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E957222568;
	Thu, 22 May 2025 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZXuAoVVf"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6079E1E32A3;
	Thu, 22 May 2025 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747899382; cv=none; b=B+dUWtvzJTrRsZcZxH5dfPxXAB3kmcRqUFCWODxIiI3MXFOHBdqRi1o2nLXCLxZ8fCX88Oz8N7V5Fz4UOCjpewK9y2uzF2i4PiOr0DczJy0UxEHqOSmjaBnsUGk5CAXIa7k1jo9qvsAmbK9K/YEfm7bm4KERwzkdQTDBlRfbbt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747899382; c=relaxed/simple;
	bh=F4i3Fk1Idix54PmX458wB/iZLA9kMy518Cyiy+f/9Eg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MuhCpdzX+WycsK0zlb4UXsC4o0jG8QWfGcXKkemEgChd7bMIniF966oqHyOAi1E04cOI3CEWrB55CB8MvrC5a+TgkEw5tM1ONZOOy81jfSOHW6TKs20FJ1AqLZx6uDxk0RLC6KprdvUdlLqRp8PGb8IJcwEroaq5DtaVdodb/10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZXuAoVVf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747899380; x=1779435380;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=F4i3Fk1Idix54PmX458wB/iZLA9kMy518Cyiy+f/9Eg=;
  b=ZXuAoVVfY4nhXv6GyKdc/mzOx5wU2ixfDhw0x/wBewM1/pHunpO2HMUE
   M9+SmpCOSkQTLZmzhWnq7zzjSo+w3iGQIB9pUHKlX8OBTLOGPKq5LFU0P
   YQqGy/ZOr3WiiKkR/8VKmnNGyy75cjpFzLtm7FJuiKDKj2gXGb7Np3lR8
   JeIFcaWyxVNWoCv0snJSBxoOL2QE5r9I56V31IOPrdwf2o3tC3x8gZ1RF
   Dxsu7MPmxVk+WNvcFwQVNDS02xJxrfjjLU3v8U800mlHJVaz14eGw1Ed/
   xU4jxWOm54vJ5mVWLzRLBfGl2EFbidrD3Jw8CnKFKt0SlSWXLQDkFG/Z+
   w==;
X-CSE-ConnectionGUID: fJJLOPzpTT6tZnT/WPJxAw==
X-CSE-MsgGUID: wX/s3yz3SoC1BpOP8b3Q3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="60150992"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="60150992"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 00:36:19 -0700
X-CSE-ConnectionGUID: rNnNqRNBRoe/uwtG46fbIg==
X-CSE-MsgGUID: w1bwDTdSThC9NBAcrX3C7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="140989093"
Received: from lkp-server01.sh.intel.com (HELO 1992f890471c) ([10.239.97.150])
  by orviesa007.jf.intel.com with ESMTP; 22 May 2025 00:36:16 -0700
Received: from kbuild by 1992f890471c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uI0TN-000P34-2F;
	Thu, 22 May 2025 07:36:13 +0000
Date: Thu, 22 May 2025 15:36:01 +0800
From: kernel test robot <lkp@intel.com>
To: Jeremy Harris <jgh@exim.org>, netdev@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	linux-api@vger.kernel.org, edumazet@google.com,
	ncardwell@google.com, Jeremy Harris <jgh@exim.org>
Subject: Re: [PATCH net-next v2 1/6]     tcp: support writing to a socket in
 listening state
Message-ID: <202505221529.hEVx1YPV-lkp@intel.com>
References: <d3f47c9b5b08237b6e76f7b0739d59089683c86e.1747826775.git.jgh@exim.org>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d3f47c9b5b08237b6e76f7b0739d59089683c86e.1747826775.git.jgh@exim.org>

Hi Jeremy,

kernel test robot noticed the following build warnings:

[auto build test WARNING on f685204c57e87d2a88b159c7525426d70ee745c9]

url:    https://github.com/intel-lab-lkp/linux/commits/Jeremy-Harris/tcp-support-writing-to-a-socket-in-listening-state/20250521-195234
base:   f685204c57e87d2a88b159c7525426d70ee745c9
patch link:    https://lore.kernel.org/r/d3f47c9b5b08237b6e76f7b0739d59089683c86e.1747826775.git.jgh%40exim.org
patch subject: [PATCH net-next v2 1/6]     tcp: support writing to a socket in listening state
config: i386-buildonly-randconfig-001-20250522 (https://download.01.org/0day-ci/archive/20250522/202505221529.hEVx1YPV-lkp@intel.com/config)
compiler: clang version 20.1.2 (https://github.com/llvm/llvm-project 58df0ef89dd64126512e4ee27b4ac3fd8ddf6247)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250522/202505221529.hEVx1YPV-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202505221529.hEVx1YPV-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> net/ipv4/tcp.c:1065:23: warning: variable 'sockc' set but not used [-Wunused-but-set-variable]
    1065 |         struct sockcm_cookie sockc;
         |                              ^
   1 warning generated.


vim +/sockc +1065 net/ipv4/tcp.c

  1059	
  1060	/* Cut-down version of tcp_sendmsg_locked(), for writing on a listen socket
  1061	 */
  1062	static int tcp_sendmsg_preload(struct sock *sk, struct msghdr *msg)
  1063	{
  1064		struct sk_buff *skb;
> 1065		struct sockcm_cookie sockc;
  1066		int flags, err, copied = 0;
  1067		int size_goal;
  1068		int process_backlog = 0;
  1069		long timeo;
  1070	
  1071		if (sk->sk_state != TCP_LISTEN)
  1072			return -EINVAL;
  1073	
  1074		flags = msg->msg_flags;
  1075	
  1076		sockc = (struct sockcm_cookie){ .tsflags = READ_ONCE(sk->sk_tsflags) };
  1077	
  1078		timeo = sock_sndtimeo(sk, flags & MSG_DONTWAIT);
  1079	
  1080		/* Ok commence sending. */
  1081	restart:
  1082		/* Use a arbitrary "mss" value */
  1083		size_goal = 1000;
  1084	
  1085		err = -EPIPE;
  1086		if (sk->sk_err || (sk->sk_shutdown & SEND_SHUTDOWN))
  1087			goto do_error;
  1088	
  1089		while (msg_data_left(msg)) {
  1090			ssize_t copy = 0;
  1091	
  1092			skb = tcp_write_queue_tail(sk);
  1093			if (skb)
  1094				copy = size_goal - skb->len;
  1095	
  1096			trace_tcp_sendmsg_locked(sk, msg, skb, size_goal);
  1097	
  1098			if (copy <= 0 || !tcp_skb_can_collapse_to(skb)) {
  1099				bool first_skb = !skb;
  1100	
  1101				/* Limit to only one skb on the sk write queue */
  1102	
  1103				if (!first_skb)
  1104					goto out_nopush;
  1105	
  1106				if (!sk_stream_memory_free(sk))
  1107					goto wait_for_space;
  1108	
  1109				if (unlikely(process_backlog >= 16)) {
  1110					process_backlog = 0;
  1111					if (sk_flush_backlog(sk))
  1112						goto restart;
  1113				}
  1114	
  1115				skb = tcp_stream_alloc_skb(sk, sk->sk_allocation,
  1116							   first_skb);
  1117				if (!skb)
  1118					goto wait_for_space;
  1119	
  1120				process_backlog++;
  1121	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

