Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E8406D3D58
	for <lists+linux-api@lfdr.de>; Mon,  3 Apr 2023 08:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbjDCGbD (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 3 Apr 2023 02:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbjDCGbC (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 3 Apr 2023 02:31:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BC5172B
        for <linux-api@vger.kernel.org>; Sun,  2 Apr 2023 23:31:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 086ED1FDA6;
        Mon,  3 Apr 2023 06:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1680503460; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sy5Nsnny2b+0IMTAD4AI1U20Acezs0lAUJhSAJ6V30I=;
        b=xwHI98HXPheq4/p1if2z+wJyMJ+I3pcFmJTj/4auLZ5HRUZG4UZHnPlJW9kUTms8eLGEil
        ecwiQxvl3BFaffLg/cV6cqOqkP69uID4H0kTvOPPAfNACNA7MjM6I7TqP7mZw6uHtJsLFx
        hDAGMMSdbn8zM2VQcfFaEYaY7/cKfc0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1680503460;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sy5Nsnny2b+0IMTAD4AI1U20Acezs0lAUJhSAJ6V30I=;
        b=kLC5MxY7imIM2hWimDGJWbPcFhZhFgnvpMK7954tXrB7SdeQXSmsPnNnlFw3SAbSg1MFFD
        uMoyawBAO70PU9Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E97291331A;
        Mon,  3 Apr 2023 06:30:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id X5DrN6NyKmQKBAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 03 Apr 2023 06:30:59 +0000
Message-ID: <9d9456f8-3072-1621-a80d-b51dd1fc33a4@suse.cz>
Date:   Mon, 3 Apr 2023 08:30:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: API/syscall to alleviate page/memory problem when quickly
 accessing memory?
To:     Levo D <l-asm@mail9fcb1a.bolinlang.com>, linux-api@vger.kernel.org,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <20230403023135.E0D9E1777C2@bolin>
Content-Language: en-US
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20230403023135.E0D9E1777C2@bolin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 4/3/23 04:31, Levo D wrote:
> I optimized and profile my program to a point that it seems like it's spending more time in kernel than in userspace (likely not true but I'll explain).
> 
> Here's one run. I spawn many threads (6 at minimum, more depending on flags). As you can see more than half of the total time is in sys. Is the kernel running on multiple cores simultaneously to give my program pages?
> 
> real	0m0.954s
> user	0m6.442s
> sys 	0m0.607s
> 
> The test below is using -test-flags which gets me these numbers, sys is 51% of total time
> 
> real	0m0.733s
> user	0m3.476s
> sys 	0m0.378s
> 
> 
> perf record -F 5000 ./myapp -test-flags shows me 61% of the app is in my biggest function and 6% is in `clear_page_rep`. When I record cache misses using `perf record -F 5000 --call-graph=fp -e cache-misses ./myapp -test-flags` I can see that
> 
> clear_page_rep takes 40%
> clear_huge_page takes 1.2%
> My big function self is 8%, while total is 25.5%. the remaining is mostly asm_exc_page_fault (12%) and asm_sysvec_apic_timer_interrupt (2.7%)
> That's about 56% (of all misses and waiting) in the kernel
> 
> I believe if I can reduce work being done in the kernel

That's not possible, the kernel must clear the pages before giving them to a
process, for security reasons.

> and have pages be ready before I fault

That it possible if you use MAP_POPULATE flag of mmap(). Or just write once
in each page before starting your large function to pre-fault it.

In that case it may also make sense not to measure time of your whole
program execution, but only between initialization (including the
pre-faulting) and cleanup. The whole runtime already seems very short to
profit from further optimizations if the init/cleanup is involved each time.
If the runtime of "large function" is important because it would be run many
times in practice, then it could also make sense to keep the initialized
process running and reusing the allocated memory instead of repeated
executions of new processes that include the free and reallocation costs.

> I'll have less cache misses in my large function and I could be significantly faster. I measured how long my large function takes in single threaded compared to multi. Multithreaded at minimum is 1.5x slower to 2x slower. I spawn 1 thread per core (I'm testing on a zen2, it has 6cores with 12threads, spawning more than 6 threads slow the program down). Each thread is using <100MB.

This seems to be more about how hyperthreading (SMT) doesn't always really
results in speed ups, so that's about the CPU vs workload rather than kernel.

> Is there an API I should look into? What can I do here?
> 
> 

