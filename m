Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F026D8538
	for <lists+linux-api@lfdr.de>; Wed,  5 Apr 2023 19:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjDERvF (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 5 Apr 2023 13:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbjDERvE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 5 Apr 2023 13:51:04 -0400
Received: from bolin (unknown [IPv6:2001:19f0:b001:f83:5400:4ff:fe1a:5b71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D710527F
        for <linux-api@vger.kernel.org>; Wed,  5 Apr 2023 10:51:04 -0700 (PDT)
Received: by bolin (Postfix, from userid 1000)
        id C81831777CE; Wed,  5 Apr 2023 17:51:02 +0000 (UTC)
From:   Levo D <l-asm@mail9fcb1a.bolinlang.com>
To:     <linux-api@vger.kernel.org>
Subject: Reduce minor faults when allocating memory?
X-Mailer: mail (GNU Mailutils 3.10)
Message-Id: <20230405175102.C81831777CE@bolin>
Date:   Wed,  5 Apr 2023 17:51:02 +0000 (UTC)
X-Spam-Status: No, score=1.3 required=5.0 tests=FSL_HELO_NON_FQDN_1,
        HELO_NO_DOMAIN,RDNS_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

I ran some test and it seems that the first time accessing memory there is about 2 minor faults per MB of data? That seems very high to me. Is there a way I can allocate more data per fault to reduce the overall fault amount?

I wrote code that I can't seem to include. It reports taking 48ms to fill the array in the first loop, 31ms the second with 770 faults in the program. That's 17ms difference between initial data fill and the second fill. There seems to be a potential to save time? The real code I'm having issues with uses about 80-100MiB per thread, 6 threads (one per core, any more than that it'll get slower). The real code suffers from cache misses and perf seems to suggest my hot loop spends 1/3rd of the time in my code and the other 2/3rds in the kernel. I'd like to reduce minor-faults if possible. Using MAP_POPULATE doesn't decrease my overall time unforunately. The test code I couldn't attach takes in an argument to use multiple threads and only measure how it takes to write 1 int every 4K. The thought is I'm causing a fault every page with the least amount of work in my code as possible and execution time should be roughly how long it takes the kernel to ready up my data. Since it took 31ms to
  fill ram I was hoping to see <=34ms (meaning 3ms of overhead), I got 38. However overhead isn't my real problem, faults and cache misses are.

Is there anything I can do to reduce the overall faults? I can increase a file pipe size with fcntl, perhaps there a setting I can change to do the same for memory in a fault? Just to reiterate, there seems to be 2 faults per MB in single threaded code and 1 or more per MB in multithreaded code. I think that's fairly high and measuring shows my hotloop spends most of the time in the kernel


