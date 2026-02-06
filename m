Return-Path: <linux-api+bounces-5812-lists+linux-api=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-api@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sCqmOC5XhWkhAQQAu9opvQ
	(envelope-from <linux-api+bounces-5812-lists+linux-api=lfdr.de@vger.kernel.org>)
	for <lists+linux-api@lfdr.de>; Fri, 06 Feb 2026 03:51:26 +0100
X-Original-To: lists+linux-api@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 633D8F9738
	for <lists+linux-api@lfdr.de>; Fri, 06 Feb 2026 03:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 301A9302F7FA
	for <lists+linux-api@lfdr.de>; Fri,  6 Feb 2026 02:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A390C292B4B;
	Fri,  6 Feb 2026 02:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="DJFw2EGU"
X-Original-To: linux-api@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438BC28CF77
	for <linux-api@vger.kernel.org>; Fri,  6 Feb 2026 02:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346257; cv=none; b=E5lfpnFF3jww5u0EeTw5g7lJBXD6lA56PJBbAddog4IDM7TqG+4q1OJQXvKKVilim8fREZaulUXxIbSoorz28y6X0t3htZDOUcgotPEARzdmNCwXp9H2HlEuvfEEKM5HcC+dgRnICscqX+zUqWf3SoOBi6Dla+Hs1iH+uETc07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346257; c=relaxed/simple;
	bh=KPsoKFcT8quPYSqcGLovDIzzaIHZundOb4SQzWLpqd4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BjdNlei3aqMyfkDZp9REusAs9xLKzbn9iwLEnJKgmGjbfiP8Y7WknwYuqV5plh9TZiJiLhFSE4K1PhiJq2MPDoNqgrosV4uQmWXXHoRrNEq6wN4wBDHM3jO0bvwpjzYjIrZ0ErTNq5GJ1BiPLgvfsBZeDb4pxDTn7z8pSx6vmWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=DJFw2EGU; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8a3825e2-4e86-4570-94e7-362ec9dd55f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770346254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BdDOF9QlOYrRUuSSIvJzRgKKYp00tJsyJhHkyge3XkY=;
	b=DJFw2EGUavWc1GwCtpN8dWcS5jnmn0DOB+k0/1yCHlQ0mFYE6+Y96jisO6uvL8bKXeyEnR
	jX0tu4kA26fb3OiEM+ApnNTDTKoImItZe0UnAFQWbZFSpFpICa3ZL5NW4ziAoQC4viwk/G
	Qgh9ZeSIsJWcMW+ZRvFyoVMidgQ6oWA=
Date: Fri, 6 Feb 2026 10:50:43 +0800
Precedence: bulk
X-Mailing-List: linux-api@vger.kernel.org
List-Id: <linux-api.vger.kernel.org>
List-Subscribe: <mailto:linux-api+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-api+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v9 9/9] selftests/bpf: Add tests to verify map
 create failure log
Content-Language: en-US
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
 KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Seth Forshee <sforshee@kernel.org>, Yuichiro Tsuji <yuichtsu@amazon.com>,
 Andrey Albershteyn <aalbersh@redhat.com>,
 Willem de Bruijn <willemb@google.com>, Jason Xing
 <kerneljasonxing@gmail.com>, Tao Chen <chen.dylane@linux.dev>,
 Mykyta Yatsenko <yatsenko@meta.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Anton Protopopov <a.s.protopopov@gmail.com>, Amery Hung
 <ameryhung@gmail.com>, Rong Tao <rongtao@cestc.cn>,
 LKML <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>,
 "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
 kernel-patches-bot@fb.com
References: <20260202144046.30651-1-leon.hwang@linux.dev>
 <20260202144046.30651-10-leon.hwang@linux.dev>
 <CAADnVQLXWQ8Miq2WBoXRDsEVP1QPwk=a5=Rj_uPN+9qKHZZmZw@mail.gmail.com>
 <11bb515b-35fd-44f3-9647-9c39580ce6a1@linux.dev>
 <CAADnVQKYwi2bNc8Hsg-r9dF0ACYYEzRyZDc33G2Kr_o0bu3bow@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <CAADnVQKYwi2bNc8Hsg-r9dF0ACYYEzRyZDc33G2Kr_o0bu3bow@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-5812-lists,linux-api=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,linux.dev,fomichev.me,google.com,amazon.com,redhat.com,meta.com,cestc.cn,fb.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,linux-api@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-api];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 633D8F9738
X-Rspamd-Action: no action



On 6/2/26 07:18, Alexei Starovoitov wrote:
> On Wed, Feb 4, 2026 at 7:54 PM Leon Hwang <leon.hwang@linux.dev> wrote:
>>
>>
>>
>> On 5/2/26 04:14, Alexei Starovoitov wrote:
>>> On Mon, Feb 2, 2026 at 6:43 AM Leon Hwang <leon.hwang@linux.dev> wrote:
>>>>
>>>> +
>>>> +#define BPF_LOG_FIXED  8
>>>> +
>>>> +static void test_map_create(enum bpf_map_type map_type, const char *map_name,
>>>> +                           struct bpf_map_create_opts *opts, const char *exp_msg)
>>>> +{
>>>> +       const int key_size = 4, value_size = 4, max_entries = 1;
>>>> +       char log_buf[128];
>>>> +       int fd;
>>>> +       LIBBPF_OPTS(bpf_log_opts, log_opts);
>>>> +
>>>> +       log_buf[0] = '\0';
>>>> +       log_opts.log_buf = log_buf;
>>>> +       log_opts.log_size = sizeof(log_buf);
>>>> +       log_opts.log_level = BPF_LOG_FIXED;
>>>
>>> Why? Which part of the test needs the log with this flag?
>>
>> BPF_LOG_FIXED looks odd here.
>>
>> This test sets 'log_level = BPF_LOG_FIXED' to match the behavior of
>> bpf_vlog_init() as initialized by bpf_log_attr_create_vlog() in
>> patch #7. BPF_LOG_FIXED is intended to be the default log_level
>> there.
> 
> I don't think you answered my question.
> bpf_vlog_init() is using whatever log_level user space provided.
> Why do you pass BPF_LOG_FIXED ?
>

The intention behind passing BPF_LOG_FIXED was to ensure the log used
the buffer in a fixed mode, since the allocated buffer was large enough
to hold the full log message from the kernel. It was not intended to
test against log_level itself.

After reviewing commit 121664093803 ("bpf: Switch BPF verifier log to be
a rotating log by default"), I realized that BPF_LOG_FIXED was
introduced specifically to disable the rotating log behavior. In this
test case, that distinction is not relevant, so BPF_LOG_FIXED is indeed
unnecessary.

I tested with 'log_level is 0' and 'log_level is non-zero'. The tests
fail when log_level is 0, and pass when log_level is non-zero. So I will
switch to using 'log_level = 1' in the next revision.

Thanks,
Leon


