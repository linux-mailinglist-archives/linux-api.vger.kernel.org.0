Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC6F6BD2EC
	for <lists+linux-api@lfdr.de>; Tue, 24 Sep 2019 21:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441930AbfIXTmn (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 24 Sep 2019 15:42:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53840 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731683AbfIXTmm (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 24 Sep 2019 15:42:42 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so1588470wmd.3;
        Tue, 24 Sep 2019 12:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b7EGVdn+nnErrmGv5RJiQcuJyaitYDwDzx3KEC+djho=;
        b=uj3bWR2VmK/66QR3ZlIpHLNCWKskaomPDlxA986ZhyJdIkhOF543pFW+O9RG/fbmQX
         rbqG9SKkRXDpU5j1GeHSYEZVNPdfTudYeFd5/QPixtahL3wobxZsc3DmlQl4DztOGP+b
         LEp3h2FPigjl4dn5VlDB/aokilgqvkSA+tPElAh7v5V5+AyNV7/7vE/RiZjBcpdF5APG
         aEcTgvHRM92XkEKNbuPgde/IL6FmHLB/+r76Pfnzf/KiwtcVuJJS41jaOycM1UoNuAXz
         6bT5xCras6yas1HVSbanZ9XyE5KbrLEs/SuljQD5bdr6Gl/kHtsCSHTzUYEcjvA0kYI/
         EbWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=b7EGVdn+nnErrmGv5RJiQcuJyaitYDwDzx3KEC+djho=;
        b=a0ht4fG69t5tK2Q3FANstXJGd8x9gAgOayyfBxNVCBeuCXJhN1BpjaDwU8Km3gQpPu
         tJJt+XVlXiK1QAcX3hQVw6PbcGOje4nDgUfhll530tAbTb7++XLcFrHn3+OF9wCZpzT1
         f2hkc8xa8QvN5COOjmxAZH33+wbWVko7pZlpbMslGzd2urYdJX8Kh8tXXj0kWQ/57xmj
         +4fdblRICLPB1NK/WuzJrq89KEwJbn+fmwIQIRCgiw7sNllp4whUHt4Ys8D6wH7SsSRn
         8jByKeegkRDR5M4COJ1wQ9vfM+FWWJIwx5cgPpulnDzDW7wjatYseweKYdZjPqxRxAGM
         XJiA==
X-Gm-Message-State: APjAAAWnSLn+xJCPZO+Gtz6JqEh1NcUK76IJMh/r4hqk2P9z8EmZCeNh
        hT5CsWDxukE1DYB4amUxbUodGN3P
X-Google-Smtp-Source: APXvYqzIcQwSY3wPxHgBCsVt3NLor66+QqJSNXyJJRRatW3wyaSbihFydYjkwvJs4CeUb2ZWCmZi2g==
X-Received: by 2002:a05:600c:24cf:: with SMTP id 15mr2192579wmu.112.1569354159344;
        Tue, 24 Sep 2019 12:42:39 -0700 (PDT)
Received: from ?IPv6:2001:a61:24d6:4e01:ef75:e978:47cd:1c50? ([2001:a61:24d6:4e01:ef75:e978:47cd:1c50])
        by smtp.gmail.com with ESMTPSA id d193sm1542839wmd.0.2019.09.24.12.42.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2019 12:42:38 -0700 (PDT)
Cc:     mtk.manpages@gmail.com, Oleg Nesterov <oleg@redhat.com>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        linux-man <linux-man@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: For review: pidfd_send_signal(2) manual page
To:     Daniel Colascione <dancol@google.com>
References: <f21dbd73-5ef4-fb5b-003f-ff4fec34a1de@gmail.com>
 <CAKOZuetMK0eRxBrR8wXo_qCaQ7OGKQHqAy15cX437+Q+cvbbvA@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Message-ID: <27cc0db0-f3b4-e4c5-70cc-2f93814c460b@gmail.com>
Date:   Tue, 24 Sep 2019 21:42:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAKOZuetMK0eRxBrR8wXo_qCaQ7OGKQHqAy15cX437+Q+cvbbvA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 9/23/19 1:31 PM, Daniel Colascione wrote:
> On Mon, Sep 23, 2019 at 2:12 AM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
>>        The  pidfd_send_signal()  system call allows the avoidance of race
>>        conditions that occur when using traditional interfaces  (such  as
>>        kill(2)) to signal a process.  The problem is that the traditional
>>        interfaces specify the target process via a process ID (PID), with
>>        the  result  that the sender may accidentally send a signal to the
>>        wrong process if the originally intended target process has termi‐
>>        nated  and its PID has been recycled for another process.  By con‐
>>        trast, a PID file descriptor is a stable reference to  a  specific
>>        process;  if  that  process  terminates,  then the file descriptor
>>        ceases to be  valid
> 
> The file *descriptor* remains valid even after the process to which it
> refers exits. You can close(2) the file descriptor without getting
> EBADF. I'd say, instead, that "a PID file descriptor is a stable
> reference to a specific process; process-related operations on a PID
> file descriptor fail after that process exits".

Thanks, Daniel. I like that rephrasing, but, since pidfd_send_signal()
is (so far as I know) currently the only relevant process-related
operation (and because this is the manual page describing that
syscall), I made it:

[[
By contrast, a PID file descriptor is a stable reference to a
specific process; if that process terminates, pidfd_send_signal()
fails with the error ESRCH.
]]

Thanks,

Michael


-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
