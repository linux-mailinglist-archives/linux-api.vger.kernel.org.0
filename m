Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 130B24EA401
	for <lists+linux-api@lfdr.de>; Tue, 29 Mar 2022 02:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbiC2AF0 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 28 Mar 2022 20:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbiC2AFY (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 28 Mar 2022 20:05:24 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CD064D6
        for <linux-api@vger.kernel.org>; Mon, 28 Mar 2022 17:03:41 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id j13so16123273plj.8
        for <linux-api@vger.kernel.org>; Mon, 28 Mar 2022 17:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=13838w1A0QhQMZDXu7rpdESYgPLiCVAkKPIN4iMNrZA=;
        b=8Lskprpcamyihf734B/BZy9vNp/+G8VNvvQQWbW9cAqGb/JSvZvjSMONWkWnDBOSYe
         05wKzKiUBXmAPJu8e0/HWvqREo214LsOdFQVL/c6EBXvXRPv9sSED2c0++/5zUyUN4nr
         o6I0AHOV1sa43McrOVaOtmDwrZRWQ3XybdYkIsAp1O+YBVvAfQPT+yiC0aoFEP2/kVGB
         oUCqLC2kUNtopL+vO/O4PX1qpDZFnqfuyoqFx12Wcq5Gm4uewISrzNSjW9hkKYH+AGD/
         NGS15Zsgf3IPYk1K0jc6whYN/D7R4bssKnmMizW2KJ1psdN6k53E1VBkf3J36qb5DSht
         yuuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=13838w1A0QhQMZDXu7rpdESYgPLiCVAkKPIN4iMNrZA=;
        b=1bFuH8RKfJpNeqZpFNGQ5HMDoNpmzgabBNGSVbeKMIvFHD+PjtSKvszbckKgHYb2VH
         jywvrRhT2IbOPKEXyHHnBdBZrcjv6+YfEiJXFvIyAG+zjzpM/+Ae09x2Tq8uhj13/f7x
         Y/tLqAUKFjtT5nZqR0M3sEuXzAfbNxrrSmiMRz864OPMFGVWz2ZQz35y2IYxAkCrOt+7
         F6mgPkWQSXv+Kh+eW+pGQ3leGPxuKnjuGZ+A9bodnBD9/+/a6J+DMQbgQtjCS+INKWMO
         2N8eJrWaejbyNJBttcOP2a4JgTKd6A9ifevBUUpDL9W0dbIU43V+5GmN3cQOza6Bowuv
         V7iw==
X-Gm-Message-State: AOAM5315t4dhk6Xvo3kE2TkMi63eL0UIqdTTR1zbsvlJATBfJfumhj95
        QhwAWRLM//Ty3ue0QfU+taSr7Q==
X-Google-Smtp-Source: ABdhPJy5Dwo5i4hUqAgLaL6hVSsz5nlw4pyTrnTpaz36xmIgt7qWX2hqsO1LZabmM/zsYKeAbaxiMA==
X-Received: by 2002:a17:902:b208:b0:14f:14e8:1e49 with SMTP id t8-20020a170902b20800b0014f14e81e49mr27413606plr.35.1648512220889;
        Mon, 28 Mar 2022 17:03:40 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id b16-20020a056a00115000b004f6ff260c9esm16448899pfm.207.2022.03.28.17.03.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Mar 2022 17:03:40 -0700 (PDT)
Message-ID: <f0a71e7a-5a81-f88f-4aaa-207ec522fb62@kernel.dk>
Date:   Mon, 28 Mar 2022 18:03:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [GIT PULL] ptrace: Cleanups for v5.18
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Alexey Gladkov <legion@kernel.org>, Kyle Huey <me@kylehuey.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
 <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
 <87tubyx0rg.fsf_-_@email.froward.int.ebiederm.org>
 <87a6d9pr5t.fsf_-_@email.froward.int.ebiederm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87a6d9pr5t.fsf_-_@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 3/28/22 5:56 PM, Eric W. Biederman wrote:
> 
> Linus,
> 
> Please pull the ptrace-cleanups-for-v5.18 tag from the git tree:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git ptrace-cleanups-for-v5.18
> 
>   HEAD: dcbc65aac28360df5f5a3b613043ccc0e81da3cf ptrace: Remove duplicated include in ptrace.c
> 
> This set of changes removes tracehook.h, moves modification of all of
> the ptrace fields inside of siglock to remove races, adds a missing
> permission check to ptrace.c
> 
> The removal of tracehook.h is quite significant as it has been a major
> source of confusion in recent years.  Much of that confusion was
> around task_work and TIF_NOTIFY_SIGNAL (which I have now decoupled
> making the semantics clearer).
> 
> For people who don't know tracehook.h is a vestiage of an attempt to
> implement uprobes like functionality that was never fully merged, and
> was later superseeded by uprobes when uprobes was merged.  For many
> years now we have been removing what tracehook functionaly a little
> bit at a time.  To the point where now anything left in tracehook.h is
> some weird strange thing that is difficult to understand.

FWIW, the notify/task_work/io_uring changes look good to me. Thanks for
cleaning this up, Eric.

-- 
Jens Axboe

