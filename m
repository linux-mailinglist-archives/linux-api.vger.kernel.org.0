Return-Path: <linux-api+bounces-2716-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C62989C5730
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 13:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B97F7B611DA
	for <lists+linux-api@lfdr.de>; Tue, 12 Nov 2024 11:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0FF12309B4;
	Tue, 12 Nov 2024 11:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WuikGcYX"
X-Original-To: linux-api@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A543230994;
	Tue, 12 Nov 2024 11:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731411167; cv=none; b=VbQuMCPViB9aEoW5cCINYOiO2JcogFGsB4OSkDq0DzPV3aERz0/Vf5cNcTNs5VEhdExtJ5QPiwsYYaagpdQjQufIiiXXASY7TDQT0brHhOdrEobMv/i3S1WEzut4BHdj3tXjd6JvtCvC8NaLwQ05l21IQClCQwnyNF9Hr0cMvlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731411167; c=relaxed/simple;
	bh=fB6Pbl+zSbpwBsUE39E1aVi2vwvz3+RH/HrJ6UaJmWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNCuqTbcgRlRKEJDI9sL3iIfVeV99fq88hMySwRoPQX1kYXmhes5r/tyD2dFHG3eHKBgW31U1x25F88i72a/52jamg6dlKmD8ohAe3Fhl/UE7uYbNVNbWuS5JD/9yn4hWL4WBcaQS04CaiUeZpwRf6MXa/2guwZFQPAI6QgT5Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WuikGcYX; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731411166; x=1762947166;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fB6Pbl+zSbpwBsUE39E1aVi2vwvz3+RH/HrJ6UaJmWU=;
  b=WuikGcYXqee8bW+yEx8z6aJ0I9lIR41ZDPdcr0BqCsSr5SBW0jfxdXQL
   yihTd3lsc/Nc9Bnfvnx3AJ4yLOnIxLzxGuZNDxy5lX4yOX1G5JYo0TqVW
   HhWaQYGU9cwh85A7e2i2tlLbDkEaLfPmOewrRP0WEyJLQKcMJd04nv72K
   RxX31WKE4mYgEybkI8zIhH/32MZdlY2o1VA0t4VszRF7/JX+q28LSZG3y
   Vf1HVCx+YQxlZmNz5u9DzcQ+7yjsL36Na4nNjdRx33mm3wMEy6axZYoAb
   2ChcMD3Oa1NdxPXo6v2QnPUW9Q8b5/H8l6gYqK2/27n5QM2Shj+nfAybd
   g==;
X-CSE-ConnectionGUID: B5hAnMcAQ1+2TJy72p3G/A==
X-CSE-MsgGUID: WkyLpDxaTremPWb35s5wwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="41802281"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="41802281"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 03:32:45 -0800
X-CSE-ConnectionGUID: 8HVvdFpkQ82ZaTglvkTpPg==
X-CSE-MsgGUID: sC3q2JTjR8SQXNHyuxN+vQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="118356315"
Received: from lkp-server01.sh.intel.com (HELO bcfed0da017c) ([10.239.97.150])
  by fmviesa001.fm.intel.com with ESMTP; 12 Nov 2024 03:32:43 -0800
Received: from kbuild by bcfed0da017c with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1tAp8S-0001Dd-1f;
	Tue, 12 Nov 2024 11:32:40 +0000
Date: Tue, 12 Nov 2024 19:32:33 +0800
From: kernel test robot <lkp@intel.com>
To: John Ousterhout <ouster@cs.stanford.edu>, netdev@vger.kernel.org,
	linux-api@vger.kernel.org
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	John Ousterhout <ouster@cs.stanford.edu>
Subject: Re: [PATCH net-next v2 12/12] net: homa: create Makefile and Kconfig
Message-ID: <202411121942.9DAb3SoN-lkp@intel.com>
References: <20241111234006.5942-13-ouster@cs.stanford.edu>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111234006.5942-13-ouster@cs.stanford.edu>

Hi John,

kernel test robot noticed the following build errors:

[auto build test ERROR on net-next/main]

url:    https://github.com/intel-lab-lkp/linux/commits/John-Ousterhout/net-homa-define-user-visible-API-for-Homa/20241112-074535
base:   net-next/main
patch link:    https://lore.kernel.org/r/20241111234006.5942-13-ouster%40cs.stanford.edu
patch subject: [PATCH net-next v2 12/12] net: homa: create Makefile and Kconfig
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20241112/202411121942.9DAb3SoN-lkp@intel.com/config)
compiler: clang version 20.0.0git (https://github.com/llvm/llvm-project 592c0fe55f6d9a811028b5f3507be91458ab2713)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241112/202411121942.9DAb3SoN-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202411121942.9DAb3SoN-lkp@intel.com/

All error/warnings (new ones prefixed by >>):

   In file included from net/homa/homa_outgoing.c:7:
   In file included from net/homa/homa_impl.h:12:
   In file included from include/linux/audit.h:13:
   In file included from include/linux/ptrace.h:10:
   In file included from include/linux/pid_namespace.h:7:
   In file included from include/linux/mm.h:2213:
   include/linux/vmstat.h:518:36: warning: arithmetic between different enumeration types ('enum node_stat_item' and 'enum lru_list') [-Wenum-enum-conversion]
     518 |         return node_stat_name(NR_LRU_BASE + lru) + 3; // skip "nr_"
         |                               ~~~~~~~~~~~ ^ ~~~
   In file included from net/homa/homa_outgoing.c:7:
   In file included from net/homa/homa_impl.h:13:
   In file included from include/linux/icmp.h:16:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:548:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     548 |         val = __raw_readb(PCI_IOBASE + addr);
         |                           ~~~~~~~~~~ ^
   include/asm-generic/io.h:561:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     561 |         val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
      37 | #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
         |                                                   ^
   In file included from net/homa/homa_outgoing.c:7:
   In file included from net/homa/homa_impl.h:13:
   In file included from include/linux/icmp.h:16:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:574:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     574 |         val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
         |                                                         ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
      35 | #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
         |                                                   ^
   In file included from net/homa/homa_outgoing.c:7:
   In file included from net/homa/homa_impl.h:13:
   In file included from include/linux/icmp.h:16:
   In file included from include/linux/skbuff.h:17:
   In file included from include/linux/bvec.h:10:
   In file included from include/linux/highmem.h:12:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/hexagon/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:14:
   In file included from arch/hexagon/include/asm/io.h:328:
   include/asm-generic/io.h:585:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     585 |         __raw_writeb(value, PCI_IOBASE + addr);
         |                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:595:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     595 |         __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
   include/asm-generic/io.h:605:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
     605 |         __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
         |                                                       ~~~~~~~~~~ ^
>> net/homa/homa_outgoing.c:108:2: warning: comparison of distinct pointer types ('typeof ((segs)) *' (aka 'int *') and 'uint64_t *' (aka 'unsigned long long *')) [-Wcompare-distinct-pointer-types]
     108 |         do_div(segs, max_seg_data);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:222:28: note: expanded from macro 'do_div'
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
>> net/homa/homa_outgoing.c:108:2: error: incompatible pointer types passing 'int *' to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
     108 |         do_div(segs, max_seg_data);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:238:22: note: expanded from macro 'do_div'
     238 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
   include/asm-generic/div64.h:213:38: note: passing argument to parameter 'dividend' here
     213 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
         |                                      ^
>> net/homa/homa_outgoing.c:108:2: warning: shift count >= width of type [-Wshift-count-overflow]
     108 |         do_div(segs, max_seg_data);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:234:25: note: expanded from macro 'do_div'
     234 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^  ~~
   include/linux/compiler.h:76:40: note: expanded from macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
>> net/homa/homa_outgoing.c:233:2: warning: comparison of distinct pointer types ('typeof ((segs_per_gso)) *' (aka 'int *') and 'uint64_t *' (aka 'unsigned long long *')) [-Wcompare-distinct-pointer-types]
     233 |         do_div(segs_per_gso, max_seg_data);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:222:28: note: expanded from macro 'do_div'
     222 |         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
         |                ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
   net/homa/homa_outgoing.c:233:2: error: incompatible pointer types passing 'int *' to parameter of type 'uint64_t *' (aka 'unsigned long long *') [-Werror,-Wincompatible-pointer-types]
     233 |         do_div(segs_per_gso, max_seg_data);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:238:22: note: expanded from macro 'do_div'
     238 |                 __rem = __div64_32(&(n), __base);       \
         |                                    ^~~~
   include/asm-generic/div64.h:213:38: note: passing argument to parameter 'dividend' here
     213 | extern uint32_t __div64_32(uint64_t *dividend, uint32_t divisor);
         |                                      ^
   net/homa/homa_outgoing.c:233:2: warning: shift count >= width of type [-Wshift-count-overflow]
     233 |         do_div(segs_per_gso, max_seg_data);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/div64.h:234:25: note: expanded from macro 'do_div'
     234 |         } else if (likely(((n) >> 32) == 0)) {          \
         |                                ^  ~~
   include/linux/compiler.h:76:40: note: expanded from macro 'likely'
      76 | # define likely(x)      __builtin_expect(!!(x), 1)
         |                                             ^
   net/homa/homa_outgoing.c:809:6: warning: variable 'checks' set but not used [-Wunused-but-set-variable]
     809 |         int checks = 0;
         |             ^
   12 warnings and 2 errors generated.


vim +108 net/homa/homa_outgoing.c

cb3634a259a2944 John Ousterhout 2024-11-11   78  
cb3634a259a2944 John Ousterhout 2024-11-11   79  /**
cb3634a259a2944 John Ousterhout 2024-11-11   80   * homa_new_data_packet() - Allocate a new sk_buff and fill it with a Homa
cb3634a259a2944 John Ousterhout 2024-11-11   81   * data packet. The resulting packet will be a GSO packet that will eventually
cb3634a259a2944 John Ousterhout 2024-11-11   82   * be segmented by the NIC.
cb3634a259a2944 John Ousterhout 2024-11-11   83   * @rpc:          RPC that packet will belong to (msgout must have been
cb3634a259a2944 John Ousterhout 2024-11-11   84   *                initialized).
cb3634a259a2944 John Ousterhout 2024-11-11   85   * @iter:         Describes location(s) of (remaining) message data in user
cb3634a259a2944 John Ousterhout 2024-11-11   86   *                space.
cb3634a259a2944 John Ousterhout 2024-11-11   87   * @offset:       Offset in the message of the first byte of data in this
cb3634a259a2944 John Ousterhout 2024-11-11   88   *                packet.
cb3634a259a2944 John Ousterhout 2024-11-11   89   * @length:       How many bytes of data to include in the skb. Caller must
cb3634a259a2944 John Ousterhout 2024-11-11   90   *                ensure that this amount of data isn't too much for a
cb3634a259a2944 John Ousterhout 2024-11-11   91   *                well-formed GSO packet, and that iter has at least this
cb3634a259a2944 John Ousterhout 2024-11-11   92   *                much data.
cb3634a259a2944 John Ousterhout 2024-11-11   93   * @max_seg_data: Maximum number of bytes of message data that can go in
cb3634a259a2944 John Ousterhout 2024-11-11   94   *                a single segment of the GSO packet.
cb3634a259a2944 John Ousterhout 2024-11-11   95   * Return: A pointer to the new packet, or a negative errno.
cb3634a259a2944 John Ousterhout 2024-11-11   96   */
cb3634a259a2944 John Ousterhout 2024-11-11   97  struct sk_buff *homa_new_data_packet(struct homa_rpc *rpc,
cb3634a259a2944 John Ousterhout 2024-11-11   98  				     struct iov_iter *iter, int offset,
cb3634a259a2944 John Ousterhout 2024-11-11   99  				     int length, int max_seg_data)
cb3634a259a2944 John Ousterhout 2024-11-11  100  {
cb3634a259a2944 John Ousterhout 2024-11-11  101  	struct homa_skb_info *homa_info;
cb3634a259a2944 John Ousterhout 2024-11-11  102  	int segs, err, gso_size;
cb3634a259a2944 John Ousterhout 2024-11-11  103  	struct data_header *h;
cb3634a259a2944 John Ousterhout 2024-11-11  104  	struct sk_buff *skb;
cb3634a259a2944 John Ousterhout 2024-11-11  105  
cb3634a259a2944 John Ousterhout 2024-11-11  106  	/* Initialize the overall skb. */
cb3634a259a2944 John Ousterhout 2024-11-11  107  	segs = length + max_seg_data - 1;
cb3634a259a2944 John Ousterhout 2024-11-11 @108  	do_div(segs, max_seg_data);
cb3634a259a2944 John Ousterhout 2024-11-11  109  	skb = homa_skb_new_tx(sizeof32(*h) + length
cb3634a259a2944 John Ousterhout 2024-11-11  110  			+ segs * sizeof32(struct seg_header));
cb3634a259a2944 John Ousterhout 2024-11-11  111  	if (!skb)
cb3634a259a2944 John Ousterhout 2024-11-11  112  		return ERR_PTR(-ENOMEM);
cb3634a259a2944 John Ousterhout 2024-11-11  113  
cb3634a259a2944 John Ousterhout 2024-11-11  114  	/* Fill in the Homa header (which will be replicated in every
cb3634a259a2944 John Ousterhout 2024-11-11  115  	 * network packet by GSO).
cb3634a259a2944 John Ousterhout 2024-11-11  116  	 */
cb3634a259a2944 John Ousterhout 2024-11-11  117  	h = (struct data_header *)skb_put(skb, sizeof(struct data_header));
cb3634a259a2944 John Ousterhout 2024-11-11  118  	h->common.sport = htons(rpc->hsk->port);
cb3634a259a2944 John Ousterhout 2024-11-11  119  	h->common.dport = htons(rpc->dport);
cb3634a259a2944 John Ousterhout 2024-11-11  120  	h->common.sequence = htonl(offset);
cb3634a259a2944 John Ousterhout 2024-11-11  121  	h->common.type = DATA;
cb3634a259a2944 John Ousterhout 2024-11-11  122  	homa_set_doff(h, sizeof(struct data_header));
cb3634a259a2944 John Ousterhout 2024-11-11  123  	h->common.checksum = 0;
cb3634a259a2944 John Ousterhout 2024-11-11  124  	h->common.sender_id = cpu_to_be64(rpc->id);
cb3634a259a2944 John Ousterhout 2024-11-11  125  	h->message_length = htonl(rpc->msgout.length);
cb3634a259a2944 John Ousterhout 2024-11-11  126  	h->incoming = h->message_length;
cb3634a259a2944 John Ousterhout 2024-11-11  127  	h->ack.client_id = 0;
cb3634a259a2944 John Ousterhout 2024-11-11  128  	homa_peer_get_acks(rpc->peer, 1, &h->ack);
cb3634a259a2944 John Ousterhout 2024-11-11  129  	h->retransmit = 0;
cb3634a259a2944 John Ousterhout 2024-11-11  130  	h->seg.offset = htonl(offset);
cb3634a259a2944 John Ousterhout 2024-11-11  131  
cb3634a259a2944 John Ousterhout 2024-11-11  132  	homa_info = homa_get_skb_info(skb);
cb3634a259a2944 John Ousterhout 2024-11-11  133  	homa_info->next_skb = NULL;
cb3634a259a2944 John Ousterhout 2024-11-11  134  	homa_info->wire_bytes = length + segs * (sizeof(struct data_header)
cb3634a259a2944 John Ousterhout 2024-11-11  135  			+  rpc->hsk->ip_header_length + HOMA_ETH_OVERHEAD);
cb3634a259a2944 John Ousterhout 2024-11-11  136  	homa_info->data_bytes = length;
cb3634a259a2944 John Ousterhout 2024-11-11  137  	homa_info->seg_length = max_seg_data;
cb3634a259a2944 John Ousterhout 2024-11-11  138  	homa_info->offset = offset;
cb3634a259a2944 John Ousterhout 2024-11-11  139  
cb3634a259a2944 John Ousterhout 2024-11-11  140  	if (segs > 1) {
cb3634a259a2944 John Ousterhout 2024-11-11  141  		homa_set_doff(h, sizeof(struct data_header)  -
cb3634a259a2944 John Ousterhout 2024-11-11  142  				sizeof32(struct seg_header));
cb3634a259a2944 John Ousterhout 2024-11-11  143  		gso_size = max_seg_data + sizeof(struct seg_header);
cb3634a259a2944 John Ousterhout 2024-11-11  144  		err = homa_fill_data_interleaved(rpc, skb, iter);
cb3634a259a2944 John Ousterhout 2024-11-11  145  	} else {
cb3634a259a2944 John Ousterhout 2024-11-11  146  		gso_size = max_seg_data;
cb3634a259a2944 John Ousterhout 2024-11-11  147  		err = homa_skb_append_from_iter(rpc->hsk->homa, skb, iter,
cb3634a259a2944 John Ousterhout 2024-11-11  148  						length);
cb3634a259a2944 John Ousterhout 2024-11-11  149  	}
cb3634a259a2944 John Ousterhout 2024-11-11  150  	if (err)
cb3634a259a2944 John Ousterhout 2024-11-11  151  		goto error;
cb3634a259a2944 John Ousterhout 2024-11-11  152  
cb3634a259a2944 John Ousterhout 2024-11-11  153  	if (segs > 1) {
cb3634a259a2944 John Ousterhout 2024-11-11  154  		skb_shinfo(skb)->gso_segs = segs;
cb3634a259a2944 John Ousterhout 2024-11-11  155  		skb_shinfo(skb)->gso_size = gso_size;
cb3634a259a2944 John Ousterhout 2024-11-11  156  
cb3634a259a2944 John Ousterhout 2024-11-11  157  		/* It's unclear what gso_type should be used to force software
cb3634a259a2944 John Ousterhout 2024-11-11  158  		 * GSO; the value below seems to work...
cb3634a259a2944 John Ousterhout 2024-11-11  159  		 */
cb3634a259a2944 John Ousterhout 2024-11-11  160  		skb_shinfo(skb)->gso_type =
cb3634a259a2944 John Ousterhout 2024-11-11  161  		    rpc->hsk->homa->gso_force_software ? 0xd : SKB_GSO_TCPV6;
cb3634a259a2944 John Ousterhout 2024-11-11  162  	}
cb3634a259a2944 John Ousterhout 2024-11-11  163  	return skb;
cb3634a259a2944 John Ousterhout 2024-11-11  164  
cb3634a259a2944 John Ousterhout 2024-11-11  165  error:
cb3634a259a2944 John Ousterhout 2024-11-11  166  	homa_skb_free_tx(rpc->hsk->homa, skb);
cb3634a259a2944 John Ousterhout 2024-11-11  167  	return ERR_PTR(err);
cb3634a259a2944 John Ousterhout 2024-11-11  168  }
cb3634a259a2944 John Ousterhout 2024-11-11  169  
cb3634a259a2944 John Ousterhout 2024-11-11  170  /**
cb3634a259a2944 John Ousterhout 2024-11-11  171   * homa_message_out_fill() - Initializes information for sending a message
cb3634a259a2944 John Ousterhout 2024-11-11  172   * for an RPC (either request or response); copies the message data from
cb3634a259a2944 John Ousterhout 2024-11-11  173   * user space and (possibly) begins transmitting the message.
cb3634a259a2944 John Ousterhout 2024-11-11  174   * @rpc:     RPC for which to send message; this function must not
cb3634a259a2944 John Ousterhout 2024-11-11  175   *           previously have been called for the RPC. Must be locked. The RPC
cb3634a259a2944 John Ousterhout 2024-11-11  176   *           will be unlocked while copying data, but will be locked again
cb3634a259a2944 John Ousterhout 2024-11-11  177   *           before returning.
cb3634a259a2944 John Ousterhout 2024-11-11  178   * @iter:    Describes location(s) of message data in user space.
cb3634a259a2944 John Ousterhout 2024-11-11  179   * @xmit:    Nonzero means this method should start transmitting packets;
cb3634a259a2944 John Ousterhout 2024-11-11  180   *           transmission will be overlapped with copying from user space.
cb3634a259a2944 John Ousterhout 2024-11-11  181   *           Zero means the caller will initiate transmission after this
cb3634a259a2944 John Ousterhout 2024-11-11  182   *           function returns.
cb3634a259a2944 John Ousterhout 2024-11-11  183   *
cb3634a259a2944 John Ousterhout 2024-11-11  184   * Return:   0 for success, or a negative errno for failure. It is possible
cb3634a259a2944 John Ousterhout 2024-11-11  185   *           for the RPC to be freed while this function is active. If that
cb3634a259a2944 John Ousterhout 2024-11-11  186   *           happens, copying will cease, -EINVAL will be returned, and
cb3634a259a2944 John Ousterhout 2024-11-11  187   *           rpc->state will be RPC_DEAD.
cb3634a259a2944 John Ousterhout 2024-11-11  188   */
cb3634a259a2944 John Ousterhout 2024-11-11  189  int homa_message_out_fill(struct homa_rpc *rpc, struct iov_iter *iter, int xmit)
cb3634a259a2944 John Ousterhout 2024-11-11  190  	__releases(&rpc->bucket->lock)
cb3634a259a2944 John Ousterhout 2024-11-11  191  	__acquires(&rpc->bucket->lock)
cb3634a259a2944 John Ousterhout 2024-11-11  192  {
cb3634a259a2944 John Ousterhout 2024-11-11  193  	/* Geometry information for packets:
cb3634a259a2944 John Ousterhout 2024-11-11  194  	 * mtu:              largest size for an on-the-wire packet (including
cb3634a259a2944 John Ousterhout 2024-11-11  195  	 *                   all headers through IP header, but not Ethernet
cb3634a259a2944 John Ousterhout 2024-11-11  196  	 *                   header).
cb3634a259a2944 John Ousterhout 2024-11-11  197  	 * max_seg_data:     largest amount of Homa message data that fits
cb3634a259a2944 John Ousterhout 2024-11-11  198  	 *                   in an on-the-wire packet (after segmentation).
cb3634a259a2944 John Ousterhout 2024-11-11  199  	 * max_gso_data:     largest amount of Homa message data that fits
cb3634a259a2944 John Ousterhout 2024-11-11  200  	 *                   in a GSO packet (before segmentation).
cb3634a259a2944 John Ousterhout 2024-11-11  201  	 */
cb3634a259a2944 John Ousterhout 2024-11-11  202  	int mtu, max_seg_data, max_gso_data;
cb3634a259a2944 John Ousterhout 2024-11-11  203  
cb3634a259a2944 John Ousterhout 2024-11-11  204  	int overlap_xmit, segs_per_gso;
cb3634a259a2944 John Ousterhout 2024-11-11  205  	struct sk_buff **last_link;
cb3634a259a2944 John Ousterhout 2024-11-11  206  	struct dst_entry *dst;
cb3634a259a2944 John Ousterhout 2024-11-11  207  
cb3634a259a2944 John Ousterhout 2024-11-11  208  	/* Bytes of the message that haven't yet been copied into skbs. */
cb3634a259a2944 John Ousterhout 2024-11-11  209  	int bytes_left;
cb3634a259a2944 John Ousterhout 2024-11-11  210  
cb3634a259a2944 John Ousterhout 2024-11-11  211  	int gso_size;
cb3634a259a2944 John Ousterhout 2024-11-11  212  	int err;
cb3634a259a2944 John Ousterhout 2024-11-11  213  
cb3634a259a2944 John Ousterhout 2024-11-11  214  	homa_message_out_init(rpc, iter->count);
cb3634a259a2944 John Ousterhout 2024-11-11  215  	if (unlikely(rpc->msgout.length > HOMA_MAX_MESSAGE_LENGTH ||
cb3634a259a2944 John Ousterhout 2024-11-11  216  		     rpc->msgout.length == 0)) {
cb3634a259a2944 John Ousterhout 2024-11-11  217  		err = -EINVAL;
cb3634a259a2944 John Ousterhout 2024-11-11  218  		goto error;
cb3634a259a2944 John Ousterhout 2024-11-11  219  	}
cb3634a259a2944 John Ousterhout 2024-11-11  220  
cb3634a259a2944 John Ousterhout 2024-11-11  221  	/* Compute the geometry of packets. */
cb3634a259a2944 John Ousterhout 2024-11-11  222  	dst = homa_get_dst(rpc->peer, rpc->hsk);
cb3634a259a2944 John Ousterhout 2024-11-11  223  	mtu = dst_mtu(dst);
cb3634a259a2944 John Ousterhout 2024-11-11  224  	max_seg_data = mtu - rpc->hsk->ip_header_length
cb3634a259a2944 John Ousterhout 2024-11-11  225  			- sizeof(struct data_header);
cb3634a259a2944 John Ousterhout 2024-11-11  226  	gso_size = dst->dev->gso_max_size;
cb3634a259a2944 John Ousterhout 2024-11-11  227  	if (gso_size > rpc->hsk->homa->max_gso_size)
cb3634a259a2944 John Ousterhout 2024-11-11  228  		gso_size = rpc->hsk->homa->max_gso_size;
cb3634a259a2944 John Ousterhout 2024-11-11  229  
cb3634a259a2944 John Ousterhout 2024-11-11  230  	/* Round gso_size down to an even # of mtus. */
cb3634a259a2944 John Ousterhout 2024-11-11  231  	segs_per_gso = gso_size - rpc->hsk->ip_header_length
cb3634a259a2944 John Ousterhout 2024-11-11  232  			- sizeof(struct data_header);
cb3634a259a2944 John Ousterhout 2024-11-11 @233  	do_div(segs_per_gso, max_seg_data);
cb3634a259a2944 John Ousterhout 2024-11-11  234  	if (segs_per_gso == 0)
cb3634a259a2944 John Ousterhout 2024-11-11  235  		segs_per_gso = 1;
cb3634a259a2944 John Ousterhout 2024-11-11  236  	max_gso_data = segs_per_gso * max_seg_data;
cb3634a259a2944 John Ousterhout 2024-11-11  237  
cb3634a259a2944 John Ousterhout 2024-11-11  238  	overlap_xmit = rpc->msgout.length > 2 * max_gso_data;
cb3634a259a2944 John Ousterhout 2024-11-11  239  	atomic_or(RPC_COPYING_FROM_USER, &rpc->flags);
cb3634a259a2944 John Ousterhout 2024-11-11  240  	homa_skb_stash_pages(rpc->hsk->homa, rpc->msgout.length);
cb3634a259a2944 John Ousterhout 2024-11-11  241  
cb3634a259a2944 John Ousterhout 2024-11-11  242  	/* Each iteration of the loop below creates one GSO packet. */
cb3634a259a2944 John Ousterhout 2024-11-11  243  	last_link = &rpc->msgout.packets;
cb3634a259a2944 John Ousterhout 2024-11-11  244  	for (bytes_left = rpc->msgout.length; bytes_left > 0; ) {
cb3634a259a2944 John Ousterhout 2024-11-11  245  		int skb_data_bytes, offset;
cb3634a259a2944 John Ousterhout 2024-11-11  246  		struct sk_buff *skb;
cb3634a259a2944 John Ousterhout 2024-11-11  247  
cb3634a259a2944 John Ousterhout 2024-11-11  248  		homa_rpc_unlock(rpc);
cb3634a259a2944 John Ousterhout 2024-11-11  249  		skb_data_bytes = max_gso_data;
cb3634a259a2944 John Ousterhout 2024-11-11  250  		offset = rpc->msgout.length - bytes_left;
cb3634a259a2944 John Ousterhout 2024-11-11  251  		if (skb_data_bytes > bytes_left)
cb3634a259a2944 John Ousterhout 2024-11-11  252  			skb_data_bytes = bytes_left;
cb3634a259a2944 John Ousterhout 2024-11-11  253  		skb = homa_new_data_packet(rpc, iter, offset, skb_data_bytes,
cb3634a259a2944 John Ousterhout 2024-11-11  254  					   max_seg_data);
cb3634a259a2944 John Ousterhout 2024-11-11  255  		if (unlikely(!skb)) {
cb3634a259a2944 John Ousterhout 2024-11-11  256  			err = PTR_ERR(skb);
cb3634a259a2944 John Ousterhout 2024-11-11  257  			homa_rpc_lock(rpc, "homa_message_out_fill");
cb3634a259a2944 John Ousterhout 2024-11-11  258  			goto error;
cb3634a259a2944 John Ousterhout 2024-11-11  259  		}
cb3634a259a2944 John Ousterhout 2024-11-11  260  		bytes_left -= skb_data_bytes;
cb3634a259a2944 John Ousterhout 2024-11-11  261  
cb3634a259a2944 John Ousterhout 2024-11-11  262  		homa_rpc_lock(rpc, "homa_message_out_fill2");
cb3634a259a2944 John Ousterhout 2024-11-11  263  		if (rpc->state == RPC_DEAD) {
cb3634a259a2944 John Ousterhout 2024-11-11  264  			/* RPC was freed while we were copying. */
cb3634a259a2944 John Ousterhout 2024-11-11  265  			err = -EINVAL;
cb3634a259a2944 John Ousterhout 2024-11-11  266  			homa_skb_free_tx(rpc->hsk->homa, skb);
cb3634a259a2944 John Ousterhout 2024-11-11  267  			goto error;
cb3634a259a2944 John Ousterhout 2024-11-11  268  		}
cb3634a259a2944 John Ousterhout 2024-11-11  269  		*last_link = skb;
cb3634a259a2944 John Ousterhout 2024-11-11  270  		last_link = &(homa_get_skb_info(skb)->next_skb);
cb3634a259a2944 John Ousterhout 2024-11-11  271  		*last_link = NULL;
cb3634a259a2944 John Ousterhout 2024-11-11  272  		rpc->msgout.num_skbs++;
cb3634a259a2944 John Ousterhout 2024-11-11  273  		rpc->msgout.copied_from_user = rpc->msgout.length - bytes_left;
cb3634a259a2944 John Ousterhout 2024-11-11  274  		if (overlap_xmit && list_empty(&rpc->throttled_links) && xmit)
cb3634a259a2944 John Ousterhout 2024-11-11  275  			homa_add_to_throttled(rpc);
cb3634a259a2944 John Ousterhout 2024-11-11  276  	}
cb3634a259a2944 John Ousterhout 2024-11-11  277  	atomic_andnot(RPC_COPYING_FROM_USER, &rpc->flags);
cb3634a259a2944 John Ousterhout 2024-11-11  278  	if (!overlap_xmit && xmit)
cb3634a259a2944 John Ousterhout 2024-11-11  279  		homa_xmit_data(rpc, false);
cb3634a259a2944 John Ousterhout 2024-11-11  280  	return 0;
cb3634a259a2944 John Ousterhout 2024-11-11  281  
cb3634a259a2944 John Ousterhout 2024-11-11  282  error:
cb3634a259a2944 John Ousterhout 2024-11-11  283  	atomic_andnot(RPC_COPYING_FROM_USER, &rpc->flags);
cb3634a259a2944 John Ousterhout 2024-11-11  284  	return err;
cb3634a259a2944 John Ousterhout 2024-11-11  285  }
cb3634a259a2944 John Ousterhout 2024-11-11  286  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

