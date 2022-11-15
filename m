Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2560962912A
	for <lists+linux-api@lfdr.de>; Tue, 15 Nov 2022 05:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiKOEVq (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 14 Nov 2022 23:21:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbiKOEVp (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 14 Nov 2022 23:21:45 -0500
X-Greylist: delayed 322 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Nov 2022 20:21:43 PST
Received: from juno.mpi-klsb.mpg.de (juno.mpi-klsb.mpg.de [139.19.86.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27805C763
        for <linux-api@vger.kernel.org>; Mon, 14 Nov 2022 20:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mpi-sws.org
        ; s=mail201904; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject
        :References:In-Reply-To:Message-ID:Cc:To:From:Date:sender:reply-to:content-id
        :content-description:resent-date:resent-from:resent-sender:resent-to:
        resent-cc:resent-message-id:list-id:list-help:list-unsubscribe:list-subscribe
        :list-post:list-owner:list-archive;
        bh=r0432T7jVMKum4pTQ/oaiZ/Dqwe0AOeMgD6+AgcoabM=; b=u0OZEBqLvhRz2kS1/bubuw0oc/
        jdxC/tN6ayyi577vyJ7wUzNHnDOcDYgLDtvUXcZBdasK0sV3a9YAROtJBeIzjg2ygOERc279e7n5z
        5Od2PpOUUW0ysj0XozLS0Q+szCA33K6oxhUYWqdMQmhBIQJJpHxql6piO4ySosLFTwAg=;
Received: from srv-00-62.mpi-klsb.mpg.de ([139.19.86.27]:45226 helo=max.mpi-klsb.mpg.de)
        by juno.mpi-klsb.mpg.de (envelope-from <msammler@mpi-sws.org>) 
        with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92) id 1ounMo-00021Z-Rg; Tue, 15 Nov 2022 05:16:16 +0100
Received: from [107.133.148.158] (port=57104 helo=dummy.faircode.eu)
        by max.mpi-klsb.mpg.de (envelope-from <msammler@mpi-sws.org>) 
        with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
        (Exim 4.94.2) id 1ounMo-001oYS-62; Tue, 15 Nov 2022 05:16:10 +0100
Date:   Mon, 14 Nov 2022 20:16:07 -0800 (PST)
From:   Michael Sammler <msammler@mpi-sws.org>
To:     =?UTF-8?Q?Stephen_R=C3=B6ttger?= <sroettger@google.com>
Cc:     Kees Cook <keescook@chromium.org>, linux-api@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linuxram@us.ibm.com,
        luto@amacapital.net, wad@chromium.org
Message-ID: <0a643215-03ce-4388-bd1a-301dcab87c41@mpi-sws.org>
In-Reply-To: <CAEAAPHZrMDGsAnZM=GC0bu5WpGvXaDakJBq-WDkW06aDc7_68w@mail.gmail.com>
References: <CAEAAPHZrMDGsAnZM=GC0bu5WpGvXaDakJBq-WDkW06aDc7_68w@mail.gmail.com>
Subject: Re: [RFC PATCH] seccomp: Add protection keys into seccomp_data
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Correlation-ID: <0a643215-03ce-4388-bd1a-301dcab87c41@mpi-sws.org>
X-RSPAMD-Score: -0.1 (/)
X-RSPAMD-Report: Action: no action
 Symbol: RCVD_VIA_SMTP_AUTH(0.00)
 Symbol: ARC_NA(0.00)
 Symbol: MID_RHS_MATCH_FROM(0.00)
 Symbol: FROM_HAS_DN(0.00)
 Symbol: TO_DN_SOME(0.00)
 Symbol: TO_MATCH_ENVRCPT_ALL(0.00)
 Symbol: R_SPF_NEUTRAL(0.00)
 Symbol: MIME_GOOD(-0.10)
 Symbol: DMARC_NA(0.00)
 Symbol: RCPT_COUNT_SEVEN(0.00)
 Symbol: NEURAL_HAM(-0.00)
 Symbol: FROM_EQ_ENVFROM(0.00)
 Symbol: R_DKIM_NA(0.00)
 Symbol: MIME_TRACE(0.00)
 Symbol: ASN(0.00)
 Symbol: RCVD_COUNT_TWO(0.00)
 Symbol: RCVD_TLS_ALL(0.00)
 Message-ID: 0a643215-03ce-4388-bd1a-301dcab87c41@mpi-sws.org
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org



> We're currently working on a feature in chromium that uses pkeys for
> in-process isolation. Being able to use the pkey state in the seccomp
> filter would be pretty useful for this. For example, it would allow
> us to enforce that no code outside the isolated thread would ever
> map/mprotect executable memory.
> We can probably do something similar by adding instruction pointer
> checks to the seccomp filter, but that feels quite hacky and this
> feature would make a much nicer implementation.
>
> Are there any plans to make a version 2 of this patch?

Thanks for your interest in this patch, but I am now working on other projects and currently don't plan to make a version 2 of this patch.
