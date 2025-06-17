Return-Path: <linux-api+bounces-3926-lists+linux-api=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5E9ADBED4
	for <lists+linux-api@lfdr.de>; Tue, 17 Jun 2025 03:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D4DF189321E
	for <lists+linux-api@lfdr.de>; Tue, 17 Jun 2025 01:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15D718DB35;
	Tue, 17 Jun 2025 01:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nlkEQ6EJ"
X-Original-To: linux-api@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B87647;
	Tue, 17 Jun 2025 01:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750125088; cv=none; b=V3RSYcLPB0TlMnuV/rs7EgvnDTI8qnYRL+xlcwiqbz/OhKp64CcM+yo6NvjHcNlcoCc+GOh85TDsyn6//HbTwsgkIzbm5Dw8IszxoE/tKNmMqC4uCzxRvwAy2gTYJhJRygewqZzW2/nFZ5QOqDmR6UzcB1twyM21OQctmOsSdGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750125088; c=relaxed/simple;
	bh=5KYYBXG/nAkJ1xi/D5yrAC4wQOZScmN/0NZd5CV4BJk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWSWh7D8tb2yLcIfEF/2QlGDu8rPnNy8mhpvfm3wWymSIrgUqjnZip88IKJOVDzcl8JckQvTtBW/YTNChwurCVH+ZPaOKHOLaQSxf91dQJMYO6PoPmrj0hNW9vNQjhuvxr1wDjc0DdHec1Z5DrdSpYK5QNRlU1EVbozy3YReJfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nlkEQ6EJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32779C4CEEA;
	Tue, 17 Jun 2025 01:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750125088;
	bh=5KYYBXG/nAkJ1xi/D5yrAC4wQOZScmN/0NZd5CV4BJk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nlkEQ6EJ/iP5Crl9HFErvsLjbTi0TTQPr7lu5SeDJysqLRBK/PTUnDKu5hRPjE3Pg
	 mCjVkFiUlYIbkutcMVN5Qe8LOMD1Pi/U1AzYaoLyGTkMGvjoMbw8S/a46kdt6Z7UBz
	 gE8ZK7gbNO1rX17Q8frrAiU8taLZmpnZvWxaByDUjG57QakM+tJP2PpAqVt90mXf7/
	 85pt+bpseYf9BA7y6RYgy5GvE0r3m7cb+MHSzB0BZi92Tj52HRXlUE7iCCecgDFCYj
	 VWQvdPIzc9LENAi4ZCZRdbM0BO5v91xti+pRysCLP4vqtRUpJQXc+smFNY0xX9DPo7
	 UEmcubYcDFJnw==
Date: Mon, 16 Jun 2025 21:51:26 -0400
From: Sasha Levin <sashal@kernel.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	workflows@vger.kernel.org, tools@kernel.org
Subject: Re: [RFC 08/19] exec: add API specification for execve
Message-ID: <aFDKHhaqB75Qi212@lappy>
References: <20250614134858.790460-1-sashal@kernel.org>
 <20250614134858.790460-9-sashal@kernel.org>
 <87ikkvv018.fsf@oldenburg.str.redhat.com>
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <87ikkvv018.fsf@oldenburg.str.redhat.com>

On Mon, Jun 16, 2025 at 11:39:31PM +0200, Florian Weimer wrote:
>* Sasha Levin:
>
>> +	KAPI_RETURN("long", "Does not return on success; returns -1 on error")
>> +		.type = KAPI_TYPE_INT,
>> +		.check_type = KAPI_RETURN_ERROR_CHECK,
>> +	KAPI_RETURN_END
>
>Is the -1 part correct?

Maybe :) That's one of the things I wasn't sure about: we're documenting
the execve syscall rather than the function itself. A user calling
execve() will end up with -1 on failure, and errno set with the error
code.

You could argue that it's libc that sets errno and we're trying to spec
the kernel here, not the userspace interface to it.

At the end I managed to lawyer myself into a decision that I liked: I
figured that since klibc is really a kernel library that is merely
packaged seperately from the kernel, it is really a kernel interface,
and so I followed the libc convention.

Open for suggestions...

>Many later errors during execve are not recoverable and result in execve
>succeeding (nominally) and a fatal signal being delivered to the process
>instead.  Not sure if the description covers that.

I was afraid of the "signals" rabit hole: from what I recall, you can
have fatal signals pending past the point of no return but before
execve() completes from both execve() failures as well as external
sources.

There's definitely room for a longer explanation of how all of this
works together.

I'd suggest that we tackle signal specs in the near future, and see how
we can tie those into the rest of the API specs. Right now I'm pretty
unhappy with the vague KAPI_SIGNAL().

>What about the effect of unblocking a parent thread that has vfork'ed?

In my mind it's vfork() that is waiting for the execve to complete (via
wait_for_vfork_done()) rather than execve() actively waking up the
vfork() parent.

We can list it as a side effect of execve()? I suppose that its similar
to something like read() in one process waking up a different process
from epoll_wait(), so we should probably be documenting those as well...


Thanks for the comments!

-- 
Thanks,
Sasha

