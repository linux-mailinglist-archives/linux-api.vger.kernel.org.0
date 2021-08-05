Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9251C3E0E71
	for <lists+linux-api@lfdr.de>; Thu,  5 Aug 2021 08:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbhHEGfc (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Thu, 5 Aug 2021 02:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhHEGfc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Thu, 5 Aug 2021 02:35:32 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4259C061765
        for <linux-api@vger.kernel.org>; Wed,  4 Aug 2021 23:35:18 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id dw2-20020a17090b0942b0290177cb475142so12595457pjb.2
        for <linux-api@vger.kernel.org>; Wed, 04 Aug 2021 23:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yw+dfXvJIDBVeZYoVj8XzX5qi4Azokeflw5Ku86+K6w=;
        b=GTDi+zK4gVfIGBCxIO46T6VDh1Knx03ODP2kRO1DnNsUOPLAeE6v/vSDGzYkycfWtX
         VYwqqxBDCuvvHs5SShVCIQudMwYb/AlfeasjvmOR4eHsV8B/424D0xpPGoci681z139U
         DBFzjU1NV7yibp5JbmkBhVFSxRu1NlQUr6CTbhoyd67k+k32XQGfYA3FVp52kIBL5ndT
         ejpAtNanR2uAg4G03ajOUw5vh91PGH7GruVkgTUw4iU1bpLjH20TPw6nCIOpAqgmjSKX
         Ahv0F1ykQck6neW24kGBcGelHF6i/ud4jMld+GrqcWZchonJSz9eU3gAKc3fLfmGMn0u
         z66g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yw+dfXvJIDBVeZYoVj8XzX5qi4Azokeflw5Ku86+K6w=;
        b=SwTjGGldTBohMHiOB7ttML1ZBvOSiUsVrM7fffEIgZTm+QMz+EzdDMpIbpORxtW22f
         Jx1dbDRSmB4tAHkZECX/+rGT7JIIoH3uPJGb1/6tbv4qxy/0D2FZEWwx62GAGyrkduxX
         Gsc2ZLlMJ8ANGerLIelPMnB2K3ZvPUkQsoq7AcnEVhp4FBcHaiqnQ7PaMFBAzux35Si6
         sLkEw88CFmbPwETUyJLoFWNnSblCes8mRG2WlDI8IsY0KtDKwfW/nvUbvq3YQ8eZ6rjn
         7Ta3aTpQXILswdA0lCWR5kkcBtJRImtRzwH78uLwRIJVLKzGdLQgppIs2/hlS3R2Sp6y
         mPVQ==
X-Gm-Message-State: AOAM5336LGwC+VeMh06IGmFnC/8nijiPM2GxeZXjRuVwcqGi8eDDq2tx
        ygBI2SvZRfHSeD2rhWrPrLBsnw==
X-Google-Smtp-Source: ABdhPJzhf1OaJMjLkOM/kIo9B/w+IVVstmRNwiiT3o0BYEzrLaeYNmmFs/II0q2QK/wS8jLuCzKsuA==
X-Received: by 2002:a65:6910:: with SMTP id s16mr282728pgq.270.1628145318236;
        Wed, 04 Aug 2021 23:35:18 -0700 (PDT)
Received: from google.com ([2401:fa00:9:211:8490:30e3:f52b:e185])
        by smtp.gmail.com with ESMTPSA id z15sm6184331pgc.13.2021.08.04.23.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 23:35:17 -0700 (PDT)
Date:   Thu, 5 Aug 2021 16:35:05 +1000
From:   Matthew Bobrowski <repnop@google.com>
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-api@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH v2] fanotify.7, fanotify_mark.2: Document FAN_FS_ERROR
Message-ID: <YQuGmbgZHH+VKyzB@google.com>
References: <20210804161024.3578338-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210804161024.3578338-1-krisman@collabora.com>
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

On Wed, Aug 04, 2021 at 12:10:24PM -0400, Gabriel Krisman Bertazi wrote:
> The kernel patches are not merged upstream, so please refrain from merging
> it at the moment.  This submission attempts to preview the interface
> and gather some interface review.
> 
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Jan Kara <jack@suse.cz>
> Cc: Matthew Bobrowski <repnop@google.com>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> 
> ---
> Changes since v1:
> (Matthew)
>   - Grammar fixes
>   - Don't use the term "submitted" for events sent to the listener
>   - Clarify the kind of information that is file system specific
> ---
>  man2/fanotify_mark.2 | 16 ++++++++++
>  man7/fanotify.7      | 73 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 89 insertions(+)
> 
> diff --git a/man2/fanotify_mark.2 b/man2/fanotify_mark.2
> index be3f72e040c0..2ae52f81d43b 100644
> --- a/man2/fanotify_mark.2
> +++ b/man2/fanotify_mark.2
> @@ -214,6 +214,22 @@ Create an event when a marked file or directory itself is deleted.
>  An fanotify group that identifies filesystem objects by file handles
>  is required.
>  .TP
> +.BR FAN_FS_ERROR "(since Linux 5.15)"
> +.\" commit WIP
> +Create an event when a file system error is detected.
> +A fanotify group that identifies filesystem objects by file handles
   ^ 
   An

> +is required.
> +Support for this type of notification is done per-file system,
> +but not every filesystem supports it.

IMO, I think this would be clearer by saying something like:

Support for such a notification type is dependent on the underlying
filesystem.
Not all filesystems support such notification types.

...

Also, not sure whether this has already been considered, but it may be a
good idea to keep/include a list of supported filesystems somewhere in the
man-pages too. Understand that lists generally are hard to maintain moving
forward and at some point in the future they tend to move a way from
depicting what actually is the case. As in, something like:

The filesystems that currently support FAN_FS_ERROR are:
    * ext4

Looks like this was something that was included in the kernel documentation
side of things.

> +A user can also expect to receive additional information
> +in the form of a
> +.BR FAN_EVENT_INFO_TYPE_ERROR
> +record
> +alongside the generic metadata event.
> +See
> +.BR fanotify (7)
> +for additional details.
> +.TP
>  .BR FAN_MOVED_FROM " (since Linux 5.1)"
>  .\" commit 235328d1fa4251c6dcb32351219bb553a58838d2
>  Create an event when a file or directory has been moved from a marked
> diff --git a/man7/fanotify.7 b/man7/fanotify.7
> index 6a7e70d75845..b8b7f44d4e32 100644
> --- a/man7/fanotify.7
> +++ b/man7/fanotify.7
> @@ -188,6 +188,24 @@ struct fanotify_event_info_fid {
>  .EE
>  .in
>  .PP
> +In case of a FAN_FS_ERROR event,
> +besides the file handle record,
> +an additional record describing the error that occurred
> +is included in the read buffer.

There's mention of getting a bonus file_handle, but there's no mention of
FAN_FS_ERROR being dependent on FAN_REPORT_FID. This needs to be corrected
IMO. I think the most appropriate place to put this kind of detail would be
in fanotify_mark(2) under the actual definition of FAN_FS_ERROR. I believe
it'd also make sense to document what the behavior/status code of setting a
mark on notification group without FAN_REPORT_FID actually is.

> +The structure described below, will follow the generic
> +.I fanotify_event_metadata
> +structure within the read buffer:
> +.PP
> +.in +4n
> +.EX
> +struct fanotify_event_info_error {
> +    struct fanotify_event_info_header hdr;
> +    __s32 error;
> +    __u32 error_count;
> +};
> +.EE
> +.in
> +.PP
>  For performance reasons, it is recommended to use a large
>  buffer size (for example, 4096 bytes),
>  so that multiple events can be retrieved by a single
> @@ -311,6 +329,9 @@ A child file or directory was deleted in a watched parent.
>  .B FAN_DELETE_SELF
>  A watched file or directory was deleted.
>  .TP
> +.B FAN_FS_ERROR
> +A file-system error was detected.
> +.TP
>  .B FAN_MOVED_FROM
>  A file or directory has been moved from a watched parent directory.
>  .TP
> @@ -510,6 +531,32 @@ and the file handle is followed by a null terminated string that identifies the
>  name of a directory entry in that directory, or '.' to identify the directory
>  object itself.
>  .PP
> +The fields of the
> +.I fanotify_event_info_error
> +structure are as follows:
> +.TP
> +.I hdr
> +This is a structure of type
> +.IR fanotify_event_info_header .
> +and is a generic header that contains information used to
> +describe an additional information record attached to the event.
> +For
> +.IR fanotify_event_info_error ,
> +.I info_type
> +will have the value
> +.BR FAN_EVENT_INFO_TYPE_ERROR .
> +.I len
> +has the size of the additional information record including the
> +.IR fanotify_event_info_header
> +itself.
> +.TP
> +.I error
> +Identifies the file system specific error that occured

s/occured/occurred

> +.TP
> +.I error_count
> +This counts the number of errors suppressed

This is a count of the number...

> +since the last error was read.
> +.PP
>  The following macros are provided to iterate over a buffer containing
>  fanotify event metadata returned by a
>  .BR read (2)
> @@ -599,6 +646,32 @@ field.
>  In that case, the audit subsystem will log information about the access
>  decision to the audit logs.
>  .\"
> +.SS Monitoring file systems for errors
> +A single FAN_FS_ERROR event is stored by the kernel at once.

This has to be a single FAN_FS_ERROR event per object? If so, I think we'd
need to make that clear here.

> +Extra error messages are suppressed and accounted for
> +inside the current FAN_FS_ERROR event record,
> +but details about the errors are lost.
> +.PP
> +Error types reported by FAN_FS_ERROR are file system specific
> +and not all kinds of errors are reported by all file system.

... not all kinds of error types are reported by all filesystems.

> +Refer to the file system documentation
> +for additional information on the type of errors that are reported,
> +and the meaning of those errors.
> +.PP
> +Errors not directly related to a file (i.e. super block corruption)
> +are reported with an invalid
> +.IR file_handle .
> +For these errors, the
> +.I file_handle
> +will have the field
> +.I handle_type
> +set to
> +.BR FILEID_INVALID ,
> +and the
> +.I f_handle
> +buffer set to
> +.BR 0 .
> +.\"

This might strick controversy, but for the sake of keeping things
consistent in this man page (as neither are really wrong), let's generally
stick with the following throughout the supplied updates:

s/{file system, file-system}/filesystem

:P

/M
