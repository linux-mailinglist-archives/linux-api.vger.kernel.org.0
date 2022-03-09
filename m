Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE464D3BB0
	for <lists+linux-api@lfdr.de>; Wed,  9 Mar 2022 22:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236895AbiCIVGM (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 9 Mar 2022 16:06:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbiCIVGL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 9 Mar 2022 16:06:11 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF233FBA50
        for <linux-api@vger.kernel.org>; Wed,  9 Mar 2022 13:05:10 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id e22so4225163ioe.11
        for <linux-api@vger.kernel.org>; Wed, 09 Mar 2022 13:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=WmlKE0op7yxW9mAhyAWbyDVYEcUhR6clPFPO5GZFbTM=;
        b=g6IIGqd4S1Nr27q+j3I58qCrwBg3FGnY1pbuHcSJiiF92/AFMcddAWj+4vmE1X9LkX
         0/PQ7y7qFpTJOuk7+QtuUurai9yNb3uLAUP2kkJb/LG64WNGkaG1T52ajVbj+2HqCAPT
         cLTgeYKB546fUnzXzhRAy1BaH4YDsRDd+4sil+E6DSEsZ2R0SQvVafzCh5PScGfC8wN1
         7iaW02qEWh2SmyWrOkgwUJZZTAZ3KakioC8E9Qn4YjhGCIYJ0SQutFdrdSGex06dGjEy
         4bnGNC1ArbFcxp7KjrWA/tSEXANotn5FURwGACqGn5vyVgCGvMCsSyx/KE0ZEe/Uag+/
         ludw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=WmlKE0op7yxW9mAhyAWbyDVYEcUhR6clPFPO5GZFbTM=;
        b=kczT+ga+tgDnPqoiDbZw4vs1+nPb/PN6fUABVmm8WOKcl1rY4ott8qy37VXfCyVaHz
         TugSXtpWt6OZlk3ZjaftjkUWUiLC3fvYJhpX2Ko6Df4qS2//Tjknz2GHX4h6WXdvFcaS
         EquMbbdHuUccj7Ptw8trfGwoUS16Hy+WPAVcD5KbJGm4lO8FnhswHQ6x3jgT3zmDzzS8
         vcErlX5oHu5rFwExnZKUQwJ3Lnqbcn0Kx1puxy2IRPc35NhCbrn3Ul12wLdR59M+O3L4
         EQ7WU/Y7UMA06aq8ZpPcvsFkU3PCM78juV594Qb8fExWFO9dKeZy/rzTuLKfjWDV4yRS
         SvnA==
X-Gm-Message-State: AOAM5313/EB4VN2MPTVnWv067zRNVEeHjSeAeqyxkZ4IzRezzdjJ9jPd
        LzAz/fRgozj+Coo2gjcoF643BA==
X-Google-Smtp-Source: ABdhPJxEIDVdKDuqLotwlMxIB9vNgbm9ZTeFcL5V1kO6WiXoQbbwGFcBZvhPeUUpAQp6uMm1x3nJdg==
X-Received: by 2002:a05:6638:33a0:b0:319:ae0c:b289 with SMTP id h32-20020a05663833a000b00319ae0cb289mr986493jav.55.1646859910030;
        Wed, 09 Mar 2022 13:05:10 -0800 (PST)
Received: from [192.168.1.172] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id s13-20020a6bdc0d000000b006408888551dsm1536476ioc.8.2022.03.09.13.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 13:05:09 -0800 (PST)
Message-ID: <63222e71-d2a5-47d6-a5cb-4c822441f448@kernel.dk>
Date:   Wed, 9 Mar 2022 14:05:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 00/13] Removing tracehook.h
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alexey Gladkov <legion@kernel.org>,
        Kyle Huey <me@kylehuey.com>, Oleg Nesterov <oleg@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Al Viro <viro@ZenIV.linux.org.uk>, linux-api@vger.kernel.org
References: <87a6ha4zsd.fsf@email.froward.int.ebiederm.org>
 <87bl1kunjj.fsf@email.froward.int.ebiederm.org>
 <87r19opkx1.fsf_-_@email.froward.int.ebiederm.org>
 <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <87o82gdlu9.fsf_-_@email.froward.int.ebiederm.org>
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

On 3/8/22 5:13 PM, Eric W. Biederman wrote:
> 
> While working on cleaning up do_exit I have been having to deal with the
> code in tracehook.h.  Unfortunately the code in tracehook.h does not
> make sense as organized.
> 
> This set of changes reorganizes things so that tracehook.h no longer
> exists, and so that it's current contents are organized in a fashion
> that is a little easier to understand.
> 
> The biggest change is that I lean into the fact that get_signal
> always calls task_work_run and removes the logic that tried to
> be smart and decouple task_work_run and get_signal as it has proven
> to not be effective.
> 
> This is a conservative change and I am not changing the how things
> like signal_pending operate (although it is probably justified).
> 
> A new header resume_user_mode.h is added to hold resume_user_mode_work
> which was previously known as tracehook_notify_resume.

This is a nice cleanup. I did bother me adding the TIF_NOTIFY_SIGNAL
bits and work hooks to something unrelated, but that's where other
things resided then. This makes it a lot better.

-- 
Jens Axboe

