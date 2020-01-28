Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3DAA14BD7B
	for <lists+linux-api@lfdr.de>; Tue, 28 Jan 2020 17:10:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgA1QKc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 28 Jan 2020 11:10:32 -0500
Received: from mail-io1-f47.google.com ([209.85.166.47]:34455 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbgA1QKc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 28 Jan 2020 11:10:32 -0500
Received: by mail-io1-f47.google.com with SMTP id z193so14877184iof.1
        for <linux-api@vger.kernel.org>; Tue, 28 Jan 2020 08:10:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=hc+LuODNq32hWwK88DkOGjmz3MA2YZm3s3kfV93roDY=;
        b=EWfaS20JvJCBI8DfyXVnywqJr9DZKTJSnV//am2zsu/JagfB1sDOatKdexPqKJadx6
         dVO6SP5hogS7Agck5zqjaNPq3uEu+oRTq+XMqGaxtQIdlQ7FtLycxuzNWphO41oIQ4yR
         gpghZ+eIymL8dk9cajf8LiAUsmIk2DkMAJ8yY5y5PewBdbwUjgzEUmt9nmHzLi6aqe6y
         GFDrJtf5UWsVeNyX1GzY0a9bzwtnVph0Fdcmq+51JvmUVsjp9DsNtELw+bG60mL8w2da
         FOs9cpqlwf4e6+gNBEigzF6ikEw0PmVERFxeX+AnEN0Kh792ks4WBAtZQ5gr2/66FMj+
         3xBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hc+LuODNq32hWwK88DkOGjmz3MA2YZm3s3kfV93roDY=;
        b=Ev63AvuFpp9p8I5MzCeXvjSAhOYgxKuJXtI8Pfbv3XPYYT6vaTZ1w8/EDlPY5xP+jc
         IRII2Xl8tVM8aFD4glPr5bR5QtJ4eWgOCYP/6KUdhQTJfV1FXUaI1isci+7TBKOZCh5B
         0N4e8QNZS0z7J506NvCCsSlkUiRg4K6X6kEeruq5jNX3kqGYhKC6AUJaWYKYt7ew6SNH
         0OC2qGAyMDE5HUfczbEurMV1C4Rg69KXmqIQEo3hNzy380oy/dUVOMPpXfNp69o1Tsi3
         hAjLwkblyMmU9wcABRb2GfjAdtHfRCYkg4yzfbU9TY8CSAj/3pVl4z7AuzpTlZFhvitT
         LZtA==
X-Gm-Message-State: APjAAAXS2zHrHlhCbX2XtqLuopdVIuO6i9/HiZDAYrcr3FEgl614iTKS
        1xHO0xVdwIx+nIpLfeqdO6HJ7SyXQCA=
X-Google-Smtp-Source: APXvYqxJji4jjPhD1GrI/jY9iRaPccladSxguMFZ1AOF8lPOo34Z8m705ptdoPfmj8FfRkrH/sTUug==
X-Received: by 2002:a02:cd12:: with SMTP id g18mr18550115jaq.76.1580227830927;
        Tue, 28 Jan 2020 08:10:30 -0800 (PST)
Received: from [192.168.1.159] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id a9sm5999208ilk.14.2020.01.28.08.10.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 08:10:30 -0800 (PST)
Subject: Re: IORING_REGISTER_CREDS[_UPDATE]() and credfd_create()?
To:     Stefan Metzmacher <metze@samba.org>
Cc:     io-uring <io-uring@vger.kernel.org>,
        Linux API Mailing List <linux-api@vger.kernel.org>
References: <ea9f2f27-e9fe-7016-5d5f-56fe1fdfc7a9@samba.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d6bc8139-abbe-8a8d-7da1-4eeafd9eebe7@kernel.dk>
Date:   Tue, 28 Jan 2020 09:10:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <ea9f2f27-e9fe-7016-5d5f-56fe1fdfc7a9@samba.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On 1/28/20 3:18 AM, Stefan Metzmacher wrote:
> Hi Jens,
> 
> now that we have IORING_FEAT_CUR_PERSONALITY...
> 
> How can we optimize the fileserver case now, in order to avoid the
> overhead of always calling 5 syscalls before io_uring_enter()?:
> 
>  /* gain root again */
>  setresuid(-1,0,-1); setresgid(-1,0,-1)
>  /* impersonate the user with groups */
>  setgroups(num, grps); setresgid(-1,gid,-1); setresuid(-1,uid,-1);
>  /* trigger the operation */
>  io_uring_enter();
> 
> I guess some kind of IORING_REGISTER_CREDS[_UPDATE] would be
> good, together with a IOSQE_FIXED_CREDS in order to specify
> credentials per operation.
> 
> Or we make it much more generic and introduce a credsfd_create()
> syscall in order to get an fd for a credential handle, maybe
> together with another syscall to activate the credentials of
> the current thread (or let a write to the fd trigger the activation
> in order to avoid an additional syscall number).
> 
> Having just an fd would allow IORING_REGISTER_CREDS[_UPDATE]
> to be just an array of int values instead of a more complex
> structure to define the credentials.

I'd rather avoid having to add more infrastructure for this, even if
credsfd_create() would be nifty.

With that in mind, something like:

- Application does IORING_REGISTER_CREDS, which returns some index
- Add a IORING_OP_USE_CREDS opcode, which sets the creds associated
  with dependent commands
- Actual request is linked to the IORING_OP_USE_CREDS command, any
  link off IORING_OP_USE_CREDS will use those credentials
- IORING_UNREGISTER_CREDS removes the registered creds

Just throwing that out there, definitely willing to entertain other
methods that make sense for this. Trying to avoid needing to put this
information in the SQE itself, hence the idea to use a chain of links
for it.

The downside is that we'll need to maintain an array of key -> creds,
but that's probably not a big deal.

What do you think? Ideally I'd like to get this done for 5.6 even if we
are a bit late, so you'll have everything you need with that release.

-- 
Jens Axboe

