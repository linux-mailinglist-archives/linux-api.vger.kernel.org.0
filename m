Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 719E368C9D0
	for <lists+linux-api@lfdr.de>; Mon,  6 Feb 2023 23:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjBFWyN (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Feb 2023 17:54:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjBFWyL (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Feb 2023 17:54:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B9F196BA
        for <linux-api@vger.kernel.org>; Mon,  6 Feb 2023 14:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675724001;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+u1OHKdh6SWWXlvEFuLIidGMEw5HN4SNIPpsLH0U2KY=;
        b=ZJHiAq2fJO97FI3XE0laXntR1TLcD09UWoL0W//N4YzUQEyutM3VnbJC6g0bVIOtBvlydI
        UwPXrY9agenZNO9UhEiMBMsUrHwfwdGz8be49uU82Zz7aSbqDLhpakV9jwERSWrJ5h2h02
        BlKFITLykxO209Svq5F3uV0f+sX/m5s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-277-LJNDADelN1u2WiOMFnKnqQ-1; Mon, 06 Feb 2023 17:53:18 -0500
X-MC-Unique: LJNDADelN1u2WiOMFnKnqQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7A8E811E6E;
        Mon,  6 Feb 2023 22:53:17 +0000 (UTC)
Received: from x2.localnet (unknown [10.22.11.79])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B1129400F756;
        Mon,  6 Feb 2023 22:52:47 +0000 (UTC)
From:   Steve Grubb <sgrubb@redhat.com>
To:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Richard Guy Briggs <rgb@redhat.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Eric Paris <eparis@parisplace.org>,
        Richard Guy Briggs <rgb@redhat.com>, Jan Kara <jack@suse.cz>,
        Amir Goldstein <amir73il@gmail.com>
Subject: Re: [PATCH v7 0/3] fanotify: Allow user space to pass back additional audit
 info
Date:   Mon, 06 Feb 2023 17:52:20 -0500
Message-ID: <12168436.O9o76ZdvQC@x2>
Organization: Red Hat
In-Reply-To: <cover.1675373475.git.rgb@redhat.com>
References: <cover.1675373475.git.rgb@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hello Richard,

On Friday, February 3, 2023 4:35:13 PM EST Richard Guy Briggs wrote:
> The Fanotify API can be used for access control by requesting permission
> event notification. The user space tooling that uses it may have a
> complicated policy that inherently contains additional context for the
> decision. If this information were available in the audit trail, policy
> writers can close the loop on debugging policy. Also, if this additional
> information were available, it would enable the creation of tools that
> can suggest changes to the policy similar to how audit2allow can help
> refine labeled security.
> 
> This patchset defines a new flag (FAN_INFO) and new extensions that
> define additional information which are appended after the response
> structure returned from user space on a permission event.  The appended
> information is organized with headers containing a type and size that
> can be delegated to interested subsystems.  One new information type is
> defined to audit the triggering rule number.
> 
> A newer kernel will work with an older userspace and an older kernel
> will behave as expected and reject a newer userspace, leaving it up to
> the newer userspace to test appropriately and adapt as necessary.  This
> is done by providing a a fully-formed FAN_INFO extension but setting the
> fd to FAN_NOFD.  On a capable kernel, it will succeed but issue no audit
> record, whereas on an older kernel it will fail.

I have taken the patches and built a new kernel. Everything looks good to me 
on the audit side. It's acting as expected. You can put me down for an ACK or 
tested-by or whatever is appropriate.

-Steve

> The audit function was updated to log the additional information in the
> AUDIT_FANOTIFY record. The following are examples of the new record
> format:
>   type=FANOTIFY msg=audit(1600385147.372:590): resp=2 fan_type=1
> fan_info=3137 subj_trust=3 obj_trust=5 type=FANOTIFY
> msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=0 subj_trust=2
> obj_trust=2
> 
> changelog:
> v1:
> - first version by Steve Grubb <sgrubb@redhat.com>
> Link: https://lore.kernel.org/r/2042449.irdbgypaU6@x2
> 
> v2:
> - enhancements suggested by Jan Kara <jack@suse.cz>
> - 1/3 change %d to %u in pr_debug
> - 2/3 change response from __u32 to __u16
> - mod struct fanotify_response and fanotify_perm_event add extra_info_type,
> extra_info_buf - extra_info_buf size max FANOTIFY_MAX_RESPONSE_EXTRA_LEN,
> add struct fanotify_response_audit_rule - extend debug statements
> - remove unneeded macros
> - [internal] change interface to finish_permission_event() and
> process_access_response() - 3/3 update format of extra information
> - [internal] change interface to audit_fanotify()
> - change ctx_type= to fan_type=
> Link: https://lore.kernel.org/r/cover.1651174324.git.rgb@redhat.com
> 
> v3:
> - 1/3 switch {,__}audit_fanotify() from uint to u32
> - 2/3 re-add fanotify_get_response switch case FAN_DENY: to avoid
> unnecessary churn - add FAN_EXTRA flag to indicate more info and break
> with old kernel - change response from u16 to u32 to avoid endian issues
> - change extra_info_buf to union
> - move low-cost fd check earlier
> - change FAN_RESPONSE_INFO_AUDIT_NONE to FAN_RESPONSE_INFO_NONE
> - switch to u32 for internal and __u32 for uapi
> Link: https://lore.kernel.org/all/cover.1652730821.git.rgb@redhat.com
> 
> v4:
> - scrap FAN_INVALID_RESPONSE_MASK in favour of original to catch invalid
> response == 0 - introduce FANOTIFY_RESPONSE_* macros
> - uapi: remove union
> - keep original struct fanotify_response, add fan_info infra starting with
> audit reason - uapi add struct fanotify_response_info_header{type/pad/len}
> and struct fanotify_response_info_audit_rule{hdr/rule} - rename fan_ctx=
> to fan_info=, FAN_EXTRA to FAN_INFO
> - change event struct from type/buf to len/buf
> - enable multiple info extensions in one message
> - hex encode fan_info in __audit_fanotify()
> - record type FANOTIFY extended to "type=FANOTIFY
> msg=audit(1659730979.839:284): resp=1 fan_type=0 fan_info=3F" Link:
> https://lore.kernel.org/all/cover.1659996830.git.rgb@redhat.com
> 
> v5:
> - fixed warnings in p2/4 and p3/4 found by <lkp@intel.com>
> - restore original behaviour for !FAN_INFO case and fanotify_get_response()
> - rename member audit_rule to rule_number
> - eliminate memory leak of info_buf on failure (no longer dynamic)
> - rename buf:info, count:info_len, c:remain, ib:infop
> - fix pr_debug
> - return -ENOENT on FAN_INFO and fd==FAN_NOFD to signal new kernel
> - fanotify_write() remove redundant size check
> - add u32 subj_trust obj_trust fields with unknown value "2"
> - split out to helper process_access_response_info()
> - restore finish_permission_event() response_struct to u32
> - assume and enforce one rule to audit, pass struct directly to
> __audit_fanotify() - change fanotify_perm_event struct to union
> hdr/audir_rule
> - add vspace to fanotify_write() and process_access_response_info()
> - squash 3/4 with 4/4
> - fix v3 and v4 links
> Link: https://lore.kernel.org/all/cover.1670606054.git.rgb@redhat.com
> 
> v6:
> - simplify __audit_fanotify() from audit_log_format/audit_log_n_hex to
> audit_log/%X - add comment to clarify {subj,obj}_trust values
> - remove fd processing from process_access_response_info()
> - return info_len immediately from process_access_response() on FAN_NOFD
> after process_access_response_info() Link:
> https://lore.kernel.org/all/cover.1673989212.git.rgb@redhat.com
> 
> v7:
> - change non FAN_INFO case to "0"
> - change from if-return to switch(type)-case, which now ignores non-audit
> info Link: https://lore.kernel.org/all/cover.1675373475.git.rgb@redhat.com
> 
> Richard Guy Briggs (3):
>   fanotify: Ensure consistent variable type for response
>   fanotify: define struct members to hold response decision context
>   fanotify,audit: Allow audit to use the full permission event response
> 
>  fs/notify/fanotify/fanotify.c      |  8 ++-
>  fs/notify/fanotify/fanotify.h      |  6 +-
>  fs/notify/fanotify/fanotify_user.c | 88 ++++++++++++++++++++++--------
>  include/linux/audit.h              |  9 +--
>  include/linux/fanotify.h           |  5 ++
>  include/uapi/linux/fanotify.h      | 30 +++++++++-
>  kernel/auditsc.c                   | 18 +++++-
>  7 files changed, 131 insertions(+), 33 deletions(-)




