Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87A1A6D3BE5
	for <lists+linux-api@lfdr.de>; Mon,  3 Apr 2023 04:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjDCCpK (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Sun, 2 Apr 2023 22:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbjDCCpJ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Sun, 2 Apr 2023 22:45:09 -0400
X-Greylist: delayed 510 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 02 Apr 2023 19:45:08 PDT
Received: from bolin (unknown [IPv6:2001:19f0:b001:f83:5400:4ff:fe1a:5b71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51880B759
        for <linux-api@vger.kernel.org>; Sun,  2 Apr 2023 19:45:08 -0700 (PDT)
Received: by bolin (Postfix, from userid 1000)
        id E0D9E1777C2; Mon,  3 Apr 2023 02:31:35 +0000 (UTC)
From:   Levo D <l-asm@mail9fcb1a.bolinlang.com>
To:     <linux-api@vger.kernel.org>
Subject: API/syscall to alleviate page/memory problem when quickly accessing memory?
X-Mailer: mail (GNU Mailutils 3.10)
Message-Id: <20230403023135.E0D9E1777C2@bolin>
Date:   Mon,  3 Apr 2023 02:31:35 +0000 (UTC)
X-Spam-Status: No, score=1.3 required=5.0 tests=FSL_HELO_NON_FQDN_1,
        HELO_NO_DOMAIN,RDNS_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

I optimized and profile my program to a point that it seems like it's spending more time in kernel than in userspace (likely not true but I'll explain).

Here's one run. I spawn many threads (6 at minimum, more depending on flags). As you can see more than half of the total time is in sys. Is the kernel running on multiple cores simultaneously to give my program pages?

real	0m0.954s
user	0m6.442s
sys 	0m0.607s

The test below is using -test-flags which gets me these numbers, sys is 51% of total time

real	0m0.733s
user	0m3.476s
sys 	0m0.378s


perf record -F 5000 ./myapp -test-flags shows me 61% of the app is in my biggest function and 6% is in `clear_page_rep`. When I record cache misses using `perf record -F 5000 --call-graph=fp -e cache-misses ./myapp -test-flags` I can see that

clear_page_rep takes 40%
clear_huge_page takes 1.2%
My big function self is 8%, while total is 25.5%. the remaining is mostly asm_exc_page_fault (12%) and asm_sysvec_apic_timer_interrupt (2.7%)
That's about 56% (of all misses and waiting) in the kernel

I believe if I can reduce work being done in the kernel and have pages be ready before I fault I'll have less cache misses in my large function and I could be significantly faster. I measured how long my large function takes in single threaded compared to multi. Multithreaded at minimum is 1.5x slower to 2x slower. I spawn 1 thread per core (I'm testing on a zen2, it has 6cores with 12threads, spawning more than 6 threads slow the program down). Each thread is using <100MB.

Is there an API I should look into? What can I do here?


