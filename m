Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E088D3D00DD
	for <lists+linux-api@lfdr.de>; Tue, 20 Jul 2021 19:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhGTRHJ (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Tue, 20 Jul 2021 13:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhGTRHE (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Tue, 20 Jul 2021 13:07:04 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0ACC061574;
        Tue, 20 Jul 2021 10:47:42 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id p3so17921ilg.8;
        Tue, 20 Jul 2021 10:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mojGnCKtKe4bKuPfPXowG0Y81V8x4ZUkv2eMpDDvWR4=;
        b=Tv71jpcZfBeT13xtdlCuXJMPRgi4sip8V6BWRfqvAH0mjuDPb/aMUvuKObmJS0UF9w
         V0ewkJV6pAaQoi1jbkFQ/shFD4YP59qHi+5haLa5/h7CjYgUIBQ6Tc7UMWP/LiqVJffe
         sB54PSKpD8+3DEXWnnz74an+btqi4UTbvgdLCiO1EeEOZMx0smC79db+laRowyV0eOWS
         r9X0qIaF49Iz0yzKbOGRpSVzMv+LlK0dIeHyJO4/32iC2s7EzxQluuA/CoBSNgjtsWRU
         yF4dp3dc+grC+zOpX3Q5uKhFh4hjD58UHix44VfJnrBIxWfMxOv2k/n1r3A7K16b0O7c
         JPBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mojGnCKtKe4bKuPfPXowG0Y81V8x4ZUkv2eMpDDvWR4=;
        b=V5Ho+g3amP6K8hZApoSA7cq9JGjYejkIqxjLnxujwkiXSQnBSR4CkLlNh0rgvH5TGq
         Yn8fqLKZuilntQ4taB4NZcHSaRSELtQevHjT4VIUiVf9yiO9RPR69ZL0AgcQmXOgVtaJ
         hghEVB1MMCtRiXzLpm8y7cFvbt/34UAbMk3Kk0Etiy41GRJZr+Bima/KwtNNyZErwUeP
         +6HIBtuNjJ66Krofv3vknfsNlpLh/1iQew1i8TntOxiZgorby+UEfPa3bVTNH4Hf4heS
         x8C4ozeEPSn6/mu18OXbbd9xnXOuQjqXyppcWPcyl08YeOILI/USz986vqS0UF5WHg/L
         oRhg==
X-Gm-Message-State: AOAM5322gFAngOKQgdHyb7ARjVKsNnB/rQaEbK3Oq/fPkayzCI7Js/3c
        l5kg379hFA8tcdtiKPmv8zJpMapd+IjsmL48nkY=
X-Google-Smtp-Source: ABdhPJxle6nIlOmkV6HqQVHcAVu0rpcoNrsMztVyE94ak0Bfu0+lobjcYUz4TSxs7unoPcJ7d1rdBReIsfwNGvCEMxI=
X-Received: by 2002:a92:6902:: with SMTP id e2mr21998034ilc.275.1626803262232;
 Tue, 20 Jul 2021 10:47:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210720160244.1449197-1-krisman@collabora.com>
In-Reply-To: <20210720160244.1449197-1-krisman@collabora.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 20 Jul 2021 20:47:31 +0300
Message-ID: <CAOQ4uxi9o6Vty2s+OXY5yeLDTJ2YMMO5NrAF+vmqOv69pQw0rw@mail.gmail.com>
Subject: Re: [PATCH] fanotify.7, fanotify_mark.2: Document FAN_FS_ERROR
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-man <linux-man@vger.kernel.org>,
        Khazhismel Kumykov <khazhy@google.com>,
        Jan Kara <jack@suse.cz>, Linux API <linux-api@vger.kernel.org>,
        Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

+linux-api

On Tue, Jul 20, 2021 at 7:02 PM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> The kernel patches are not merged upstream, so please refrain from merging
> it at the moment.  This submission attempts to preview the interface
> and gather some interface review.
>
> Cc: Amir Goldstein <amir73il@gmail.com>
> Cc: Jan Kara <jack@suse.cz>
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
>

Looks good as a first draft.

Thanks,
Amir.

> ---
> To: Michael Kerrisk <mtk.manpages@gmail.com>
> Cc: linux-man@vger.kernel.org
> ---
>  man2/fanotify_mark.2 | 14 +++++++++
>  man7/fanotify.7      | 72 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 86 insertions(+)
>
> diff --git a/man2/fanotify_mark.2 b/man2/fanotify_mark.2
> index be3f72e040c0..500e41faa4f0 100644
> --- a/man2/fanotify_mark.2
> +++ b/man2/fanotify_mark.2
> @@ -214,6 +214,20 @@ Create an event when a marked file or directory itself is deleted.
>  An fanotify group that identifies filesystem objects by file handles
>  is required.
>  .TP
> +.BR FAN_FS_ERROR "(since Linux 5.15)"
> +.\" commit WIP
> +Create an event when a file system error is detected.
> +A fanotify group that identifies filesystem objects by file handles
> +is required.
> +Support for this type of notification is done per-file system,
> +but not every filesystem supports it.
> +Additional information is submitted in the form of a
> +.BR FAN_EVENT_INFO_TYPE_ERROR
> +record.
> +See
> +.BR fanotify (7)
> +for additional details.
> +.TP
>  .BR FAN_MOVED_FROM " (since Linux 5.1)"
>  .\" commit 235328d1fa4251c6dcb32351219bb553a58838d2
>  Create an event when a file or directory has been moved from a marked
> diff --git a/man7/fanotify.7 b/man7/fanotify.7
> index 6a7e70d75845..155ba8273463 100644
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
> +is a generic header that contains information used to
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
> +.TP
> +.I error_count
> +This counts the number of errors suppressed
> +since the last error was read.
> +.PP
>  The following macros are provided to iterate over a buffer containing
>  fanotify event metadata returned by a
>  .BR read (2)
> @@ -599,6 +646,31 @@ field.
>  In that case, the audit subsystem will log information about the access
>  decision to the audit logs.
>  .\"
> +.SS Monitoring file systems for error
> +A single FAN_FS_ERROR event is stored by the kernel at once.
> +Extra error messages are suppressed and accounted
> +inside the current FAN_FS_ERROR event record,
> +but details about the errors are lost.
> +.PP
> +Error types reported by FAN_FS_ERROR are file system specific
> +and not all kinds of error are reported by all file system.
> +Refer to the file system documentation
> +for the information of which errors are reported,
> +and the meaning of those errors.
> +.PP
> +Errors not directly related to a file (i.e. super block corruption)
> +are reported with an invalid file handler.
> +For these errors,
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
>  .SS Closing the fanotify file descriptor
>  When all file descriptors referring to the fanotify notification group are
>  closed, the fanotify group is released and its resources
> --
> 2.32.0
>
