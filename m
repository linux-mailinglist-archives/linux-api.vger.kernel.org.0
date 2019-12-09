Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A77211763E
	for <lists+linux-api@lfdr.de>; Mon,  9 Dec 2019 20:49:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbfLITth convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-api@lfdr.de>); Mon, 9 Dec 2019 14:49:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35666 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbfLITth (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 9 Dec 2019 14:49:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id c20so616418wmb.0
        for <linux-api@vger.kernel.org>; Mon, 09 Dec 2019 11:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:user-agent:in-reply-to:references
         :mime-version:content-transfer-encoding:subject:to:cc:from
         :message-id;
        bh=FetqLdZTgqYVH7ikYZFDoVL0KC42SrD46xkQJuqyRM0=;
        b=dzy9TaSYrgIitcmzbfyvxrWnpiS4nc8qxdJxwkSeN1KPxlylm81pG9Pk5dvEFmRoDA
         z8/66/gccf+ecvOuhYFZzsJoFlQc5KVIof18BMDx7M+dHOgZaa60MoUbePSi69UcpUBD
         mKR3TnHa1sqXy/acAB3s7wb+fmxHzimoNqo/aRGbTk5ShEa2jMya75WBxbOd8HlBV9Vc
         p0y51uD2O2Xn6r8R6uSJGORBSF7Q4Vpi5coCQVF+HW5bn3guStGjhskB1en1q5dqfdL+
         XNHiQ44u/nQxPVfKqgF+8hZ+E7Mypd2ZaSwVt4lzaSJVCyHsGMKugtmTbZNjW9MwT2Q3
         czig==
X-Gm-Message-State: APjAAAX2hqIf4R3DuH3tYbbUlupS28hU+U78hNRv8GKF9gk5xcBBFgCU
        Tsy6MsVo6kwYEKCLfR/NoKuPqFr2Vp+O6A==
X-Google-Smtp-Source: APXvYqzwdtZwcs4aWr/n3Y0vKZr/hBTDd8QXrLwOo8iigFvCVNTzOKX0Gg9TpN8KcfynfzDWIDYi9w==
X-Received: by 2002:a1c:41c4:: with SMTP id o187mr819910wma.24.1575920974952;
        Mon, 09 Dec 2019 11:49:34 -0800 (PST)
Received: from [10.152.225.171] ([185.81.138.20])
        by smtp.gmail.com with ESMTPSA id y6sm590029wrl.17.2019.12.09.11.49.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Dec 2019 11:49:34 -0800 (PST)
Date:   Mon, 09 Dec 2019 20:49:30 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <20191209192959.GB10721@redhat.com>
References: <20191209070646.GA32477@ircssh-2.c.rugged-nimbus-611.internal> <20191209192959.GB10721@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v2 4/4] samples: Add example of using PTRACE_GETFD in conjunction with user trap
To:     Oleg Nesterov <oleg@redhat.com>, Sargun Dhillon <sargun@sargun.me>
CC:     linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tycho@tycho.ws, jannh@google.com,
        cyphar@cyphar.com, luto@amacapital.net, viro@zeniv.linux.org.uk
From:   Christian Brauner <christian.brauner@ubuntu.com>
Message-ID: <BE3E056F-0147-4A00-8FF7-6CC9DE02A30C@ubuntu.com>
Sender: linux-api-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On December 9, 2019 8:30:00 PM GMT+01:00, Oleg Nesterov <oleg@redhat.com> wrote:
>On 12/09, Sargun Dhillon wrote:
>>
>> +#define CHILD_PORT_TRY_BIND	80
>> +#define CHILD_PORT_ACTUAL_BIND	4998
>
>...
>
>> +static int handle_req(int listener)
>> +{
>> +	struct sockaddr_in addr = {
>> +		.sin_family	= AF_INET,
>> +		.sin_port	= htons(4998),
>
>then I think
>		.sin_port = htons(CHILD_PORT_ACTUAL_BIND);
>
>would be more clear...
>
>> +		.sin_addr	= {
>> +			.s_addr	= htonl(INADDR_LOOPBACK)
>> +		}
>> +	};
>> +	struct ptrace_getfd_args getfd_args = {
>> +		.options = PTRACE_GETFD_O_CLOEXEC
>> +	};
>> +	struct seccomp_notif_sizes sizes;
>> +	struct seccomp_notif_resp *resp;
>> +	struct seccomp_notif *req;
>> +	int fd, ret = 1;
>> +
>> +	if (seccomp(SECCOMP_GET_NOTIF_SIZES, 0, &sizes) < 0) {
>> +		perror("seccomp(GET_NOTIF_SIZES)");
>> +		goto out;
>> +	}
>> +	req = malloc(sizes.seccomp_notif);
>> +	if (!req)
>> +		goto out;
>> +	memset(req, 0, sizeof(*req));
>> +
>> +	resp = malloc(sizes.seccomp_notif_resp);
>> +	if (!resp)
>> +		goto out_free_req;
>> +	memset(resp, 0, sizeof(*resp));
>> +
>> +	if (ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, req)) {
>> +		perror("ioctl recv");
>> +		goto out;
>> +	}
>> +	printf("Child tried to call bind with fd: %lld\n",
>req->data.args[0]);
>> +	getfd_args.fd = req->data.args[0];
>> +	fd = ptrace_getfd(req->pid, &getfd_args);
>
>and iiuc otherwise you do not need to ptrace the child. So you could
>remove
>ptrace(PTRACE_SEIZE) in main() and just do
>
>	ptrace(PTRACE_SEIZE, req->pid);
>	fd = ptrace_getfd(req->pid, &getfd_args);
>	ptrace(PTRACE_DETACH, req->pid);
>
>here. However, PTRACE_DETACH won't work, it needs the stopped tracee.
>We can
>add PTRACE_DETACH_ASYNC, but this makes me think that PTRACE_GETFD has
>nothing
>to do with ptrace.
>
>May be a new syscall which does ptrace_may_access() + get_task_file()
>will make
>more sense?
>
>Oleg.

Once more since this annoying app uses html by default...

But we can already do this right now and this is just an improvement.
That's a bit rich for a new syscall imho...

Christian
