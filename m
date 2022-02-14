Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBC224B5D16
	for <lists+linux-api@lfdr.de>; Mon, 14 Feb 2022 22:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231486AbiBNVlA (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 14 Feb 2022 16:41:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiBNVk7 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 14 Feb 2022 16:40:59 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E0C10856A
        for <linux-api@vger.kernel.org>; Mon, 14 Feb 2022 13:40:51 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id y9so15768720pjf.1
        for <linux-api@vger.kernel.org>; Mon, 14 Feb 2022 13:40:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:message-id:mime-version:content-disposition;
        bh=we3oebmikwpKhsI1NkWXkOZeCaOGVTtpGTBB8FMFGM8=;
        b=LSdAefTMOx41Nq6cSVwKgC+jp0ECLs/qZc+CUf7lgR0rx4VTnSZhYiPTCexVz25ZHs
         GdRV0ndGnhIAghiCALf3QFgrN6uimyQiGGq0GH6BZX3BeKShMuqKJyJHcEWhpJ0Vylxr
         +m4Xk9/1GiwisZCRRCEFJ0kWVuAPS8TrPL+1w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition;
        bh=we3oebmikwpKhsI1NkWXkOZeCaOGVTtpGTBB8FMFGM8=;
        b=HxZe9DyJizk1kcFY+gXK8ipeMLew/DxyJEKS9eljjSKaDIATcw5Ei1Iv9H8idzGNgw
         i59Wwvdi+ncdkFyCT7WsZVdc+HutP2aLaBMKyaNtrpPLCtNJK2nD9awIl8SDXqfyK2wV
         JQ0EdjY5fd4AHI6/TnLLZPBr5XY1tBospClC3p9PHyoY2ZKpZKjJ+KCZfeeoCeOAMe0L
         e0JVVgUfiQYDsRcPVpAdBBEPmqtlNiQro5ys8ZUMhn6Cr3qHMnWO8vm8R3QcMZbn+n+w
         RG9/kMjgN82PdLDSB1T/lgW9nPaHX8XBAzyxMKnmRM4qUweo4rPL6ZfZlgY9Hl9MwDOk
         gwDA==
X-Gm-Message-State: AOAM532GRSR5s+eIkba3r2DvQCzgHxCQFc+e/8MQJqboqKDRdDHy2C7m
        KmCPTTsOF3mNmh7tdAS7C1lvnXT+UgAPVQ==
X-Google-Smtp-Source: ABdhPJxrpBB/JwcpBBbNFECqJfvcAT5VIjXa1JpYywVDqVqyxJknHuC+3F9lJTetLHUbdstfiEYamQ==
X-Received: by 2002:a17:902:8215:: with SMTP id x21mr802188pln.99.1644874850757;
        Mon, 14 Feb 2022 13:40:50 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o2sm445389pga.57.2022.02.14.13.40.50
        for <linux-api@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 13:40:50 -0800 (PST)
Date:   Mon, 14 Feb 2022 13:40:49 -0800
From:   Kees Cook <keescook@chromium.org>
To:     linux-api@vger.kernel.org
Subject: discovering native audit arch
Message-ID: <202202141339.94EF9CAF@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Hi,

Is there a better way than this to find the native architecture value
needed for seccomp filters? Right now everyone basically hard-codes it
with other compile-time checks...

static unsigned int get_syscall_arch(void)
{
	struct ptrace_syscall_info info = { };
	siginfo_t siginfo = { };
	unsigned int arch = -1;
	pid_t pid = fork();

	if (pid < 0)
		return -1;
	if (pid == 0) {
		if (ptrace(PTRACE_TRACEME, 0, 0, 0) != 0) {
			perror("PTRACE_TRACEME");
			_exit(1);
		}
		if (raise(SIGSTOP) != 0) {
			perror("raise");
			_exit(1);
		}
		_exit(0);
	}
	if (ptrace(PTRACE_ATTACH, pid, 0, 0) != 0)
		goto reap;
	if (waitid(P_PID, pid, &siginfo, WEXITED | WSTOPPED | WCONTINUED) != 0)
		goto reap;
	if (siginfo.si_code != CLD_STOPPED &&
	    siginfo.si_code != CLD_TRAPPED)
		goto reap;
	if (ptrace(PTRACE_GET_SYSCALL_INFO, pid, sizeof(info), &info)
	    < offsetof(typeof(info), arch) + sizeof(info.arch))
		goto reap;
	arch = info.arch;
	ptrace(PTRACE_DETACH, pid, 0, 0);
reap:
	kill(pid, SIGKILL);
	if (waitpid(pid, NULL, 0) != pid)
		perror("waitpid");
	return arch;
}


-- 
Kees Cook
